import Foundation

/// Filters and sorts Pokémon in-memory. Called synchronously from the reducer.
protocol FilterPokemonUseCase {
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SortOrder) -> [Pokemon]
}

final class DefaultFilterPokemonUseCase: FilterPokemonUseCase {
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SortOrder) -> [Pokemon] {
        let filteredByGeneration = filterByGeneration(pokemons, generation: generation)
        return sort(filteredByGeneration, by: sortType, order: sortOrder)
    }
    
    private func filterByGeneration(_ pokemons: [Pokemon], generation: PokemonGeneration) -> [Pokemon] {
        if generation == .all {
            return pokemons
        }
        return pokemons.filter { generation.range.contains($0.id) }
    }
    
    private func sort(_ pokemons: [Pokemon], by sortType: SortType, order: SortOrder) -> [Pokemon] {
        switch (sortType, order) {
        case (.name, .ascending):
            return pokemons.sorted { $0.name < $1.name }
        case (.name, .descending):
            return pokemons.sorted { $0.name > $1.name }
        case (.id, .ascending):
            return pokemons.sorted { $0.id < $1.id }
        case (.id, .descending):
            return pokemons.sorted { $0.id > $1.id }
        }
    }
}
