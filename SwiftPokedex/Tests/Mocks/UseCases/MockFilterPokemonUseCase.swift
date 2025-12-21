import Foundation
@testable import SwiftPokedex

class MockFilterPokemonUseCase: FilterPokemonUseCase {
    var filterResult: [Pokemon] = []
    
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SwiftPokedex.SortOrder) -> [Pokemon] {
        filterResult
    }
}
