import Foundation
@testable import SwiftPokedex

final class PokemonAudioServiceMock: PokemonAudioServiceProtocol {
    // Stub
    var playPokemonCryToBeReturned: Result<Void, Error> = .success(())

    // Spy
    private(set) var playPokemonCryNamePassed: String?

    func playPokemonCry(for name: String) async throws {
        playPokemonCryNamePassed = name
        try playPokemonCryToBeReturned.get()
    }
}
