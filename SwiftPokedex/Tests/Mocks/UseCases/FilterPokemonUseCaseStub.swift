import Foundation
@testable import SwiftPokedex

/// Test double — returns a pre-set list regardless of filter/sort params.
final class FilterPokemonUseCaseStub: FilterPokemonUseCase {
    var executeToBeReturned: [Pokemon] = []

    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SwiftPokedex.SortOrder) -> [Pokemon] {
        executeToBeReturned
    }
}
