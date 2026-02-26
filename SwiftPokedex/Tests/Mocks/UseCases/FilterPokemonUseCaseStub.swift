import Foundation
@testable import SwiftPokedex

final class FilterPokemonUseCaseStub: FilterPokemonUseCase {
    var executeToBeReturned: [Pokemon] = []

    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SwiftPokedex.SortOrder) -> [Pokemon] {
        executeToBeReturned
    }
}
