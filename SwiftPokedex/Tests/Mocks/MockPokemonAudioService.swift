import Foundation
@testable import SwiftPokedex

class MockPokemonAudioService: PokemonAudioServiceProtocol {
    var playResult: Result<Void, Error> = .success(())
    var playedPokemonName: String?
    
    func playPokemonCry(for name: String) async throws {
        playedPokemonName = name
        try playResult.get()
    }
}
