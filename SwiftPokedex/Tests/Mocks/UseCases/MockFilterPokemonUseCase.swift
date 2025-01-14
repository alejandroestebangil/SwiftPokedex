//
//  MockFilterPokemonUseCase.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import Foundation
@testable import SwiftPokedex

class MockFilterPokemonUseCase: FilterPokemonUseCase {
    var filterResult: [Pokemon] = []
    
    func execute(pokemons: [Pokemon], generation: PokemonGeneration, sortType: SortType, sortOrder: SwiftPokedex.SortOrder) -> [Pokemon] {
        filterResult
    }
}
