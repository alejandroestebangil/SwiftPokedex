//
//  FetchPokemonListUseCase.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import Foundation
import Dependencies

protocol FetchPokemonListUseCase {
    func execute() async throws -> [Pokemon]
}

final class DefaultFetchPokemonListUseCase: FetchPokemonListUseCase {
    @Dependency(\.pokemonRepository) private var repository
    
    func execute() async throws -> [Pokemon] {
        return try await repository.fetchPokemonList()
    }
}
