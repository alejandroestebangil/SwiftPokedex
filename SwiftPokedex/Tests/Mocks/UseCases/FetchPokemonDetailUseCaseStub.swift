import Foundation
@testable import SwiftPokedex

/// Test double — returns a configurable detail result without hitting the network.
final class FetchPokemonDetailUseCaseStub: FetchPokemonDetailUseCase {
    var executeToBeReturned: Result<PokemonDetail, Error> = .success(.fixture())

    func execute(id: Int) async throws -> PokemonDetail {
        try executeToBeReturned.get()
    }
}
