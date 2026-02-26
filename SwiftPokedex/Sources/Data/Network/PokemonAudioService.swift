import AVFoundation

protocol PokemonAudioServiceProtocol {
    func playPokemonCry(for name: String) async throws
}

final class PokemonAudioService: NSObject, PokemonAudioServiceProtocol, AVAudioPlayerDelegate, @unchecked Sendable {
    private var audioPlayer: AVAudioPlayer?
    private var continuation: CheckedContinuation<Void, Error>?

    func playPokemonCry(for name: String) async throws {
        let formattedName = name.lowercased()

        guard let url = URL(string: "https://play.pokemonshowdown.com/audio/cries/\(formattedName).mp3") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        try await withCheckedThrowingContinuation { continuation in
            do {
                let player = try AVAudioPlayer(data: data)
                player.delegate = self
                self.audioPlayer = player
                self.continuation = continuation
                player.play()
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            continuation?.resume()
        } else {
            continuation?.resume(throwing: URLError(.unknown))
        }
        continuation = nil
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        continuation?.resume(throwing: error ?? URLError(.unknown))
        continuation = nil
    }
}
