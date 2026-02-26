import Foundation
@testable import SwiftPokedex

final class PlayPokemonCryUseCaseMock: PlayPokemonCryUseCase {
    // Stub
    var executeToBeReturned: Result<Void, Error> = .success(())

    // Spy
    private(set) var executeNamePassed: String?

    func execute(pokemonName: String) async throws {
        executeNamePassed = pokemonName
        try executeToBeReturned.get()
    }
}
