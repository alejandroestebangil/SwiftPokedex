import AVFoundation

protocol PokemonAudioServiceProtocol: Sendable {
    func playPokemonCry(for name: String) async throws
}

/// Uses `actor` isolation to prevent concurrent playback and data races on `delegate`.
actor PokemonAudioService: PokemonAudioServiceProtocol {
    /// Non-nil while audio is playing; acts as a concurrency guard.
    private var delegate: AudioPlayerDelegate?

    func playPokemonCry(for name: String) async throws {
        /// Reject concurrent calls — only one cry can play at a time.
        guard delegate == nil else { throw URLError(.cancelled) }

        let formattedName = name.lowercased()

        guard let url = URL(string: "https://play.pokemonshowdown.com/audio/cries/\(formattedName).mp3") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            do {
                /// Delegate bridges AVAudioPlayerDelegate callbacks into the continuation.
                /// It guarantees the continuation is resumed exactly once via atomic flag.
                let playerDelegate = AudioPlayerDelegate { [weak self] result in
                    Task { await self?.clearDelegate() }
                    switch result {
                    case .success:
                        continuation.resume()
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
                let player = try AVAudioPlayer(data: data)
                player.delegate = playerDelegate
                self.delegate = playerDelegate
                player.play()
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    /// Resets delegate so the next call to `playPokemonCry` is allowed.
    private func clearDelegate() {
        delegate = nil
    }
}

/// Bridges AVAudioPlayer delegate callbacks into a single completion closure.
/// Uses an atomic flag to ensure the completion is invoked exactly once,
/// even if both delegate methods fire (e.g. decode error + finish).
private final class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate, Sendable {
    private let completion: @Sendable (Result<Void, Error>) -> Void
    private let called = ManagedAtomic(false)

    init(completion: @escaping @Sendable (Result<Void, Error>) -> Void) {
        self.completion = completion
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        guard called.exchange(true) == false else { return }
        if flag {
            completion(.success(()))
        } else {
            completion(.failure(URLError(.unknown)))
        }
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard called.exchange(true) == false else { return }
        completion(.failure(error ?? URLError(.unknown)))
    }
}

/// Lightweight lock-based atomic for a single value.
/// Used instead of `os_unfair_lock` or Swift Atomics to avoid extra dependencies.
private final class ManagedAtomic<Value>: @unchecked Sendable {
    private let lock = NSLock()
    private var value: Value

    init(_ value: Value) {
        self.value = value
    }

    /// Atomically replaces the value and returns the old one.
    func exchange(_ newValue: Value) -> Value {
        lock.lock()
        defer { lock.unlock() }
        let old = value
        value = newValue
        return old
    }
}
