//
//  MockFilterPokemonUseCase.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import Foundation
@testable import AdidasPokedex

class MockFilterPokemonUseCase: FilterPokemonUseCase {
    var filterResult: [Pokemon] = []
    
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: AdidasPokedex.SortOrder) -> [Pokemon] {
        filterResult
    }
}
