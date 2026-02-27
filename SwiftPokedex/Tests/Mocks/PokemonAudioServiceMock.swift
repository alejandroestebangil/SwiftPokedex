import Foundation
@testable import SwiftPokedex

/// Stub + spy for the audio service — records the name passed and returns a configurable result.
final class PokemonAudioServiceMock: PokemonAudioServiceProtocol {
    var playPokemonCryToBeReturned: Result<Void, Error> = .success(())
    private(set) var playPokemonCryNamePassed: String?

    func playPokemonCry(for name: String) async throws {
        playPokemonCryNamePassed = name
        try playPokemonCryToBeReturned.get()
    }
}
