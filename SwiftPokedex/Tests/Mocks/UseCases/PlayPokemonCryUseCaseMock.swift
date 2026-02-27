import Foundation
@testable import SwiftPokedex

/// Stub + spy — records the name passed and returns a configurable result.
final class PlayPokemonCryUseCaseMock: PlayPokemonCryUseCase {
    var executeToBeReturned: Result<Void, Error> = .success(())
    private(set) var executeNamePassed: String?

    func execute(pokemonName: String) async throws {
        executeNamePassed = pokemonName
        try executeToBeReturned.get()
    }
}
