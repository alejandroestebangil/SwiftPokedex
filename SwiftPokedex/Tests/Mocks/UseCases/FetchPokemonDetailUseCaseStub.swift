import Foundation
@testable import SwiftPokedex

final class FetchPokemonDetailUseCaseStub: FetchPokemonDetailUseCase {
    var executeToBeReturned: Result<PokemonDetail, Error> = .success(.fixture())

    func execute(id: Int) async throws -> PokemonDetail {
        try executeToBeReturned.get()
    }
}
