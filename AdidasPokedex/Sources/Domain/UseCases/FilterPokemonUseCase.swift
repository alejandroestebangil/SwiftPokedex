//
//  FilterPokemonUseCase.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 5/12/24.
//

import Foundation

protocol FilterPokemonUseCase {
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SortOrder) -> [Pokemon]
}

final class DefaultFilterPokemonUseCase: FilterPokemonUseCase {
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SortOrder) -> [Pokemon] {
        // First filter by generation
        let filteredByGeneration = filterByGeneration(pokemons, generation: generation)
        
        // Then sort by name
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
