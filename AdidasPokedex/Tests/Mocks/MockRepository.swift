//
//  MockRepository.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import Foundation
@testable import AdidasPokedex

class MockPokemonRepository: PokemonRepository {
    var pokemonListResult: Result<[Pokemon], Error> = .success([])
    var pokemonDetailResult: Result<PokemonDetail, Error> = .success(PokemonDetail(id: 0, name: "", imageUrl: "", types: [], weight: 0, height: 0, baseStats: []))
    
    func fetchPokemonList() async throws -> [Pokemon] {
        try pokemonListResult.get()
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        try pokemonDetailResult.get()
    }
}

// Test Error
enum TestError: Error {
    case someError
}
