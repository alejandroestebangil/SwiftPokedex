//
//  FetchPokemonListUseCase.swift
//  PokeApiProject
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

protocol FetchPokemonListUseCase {
    func execute() async throws -> [Pokemon]
}

final class DefaultFetchPokemonListUseCase: FetchPokemonListUseCase {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Pokemon] {
        return try await repository.fetchPokemonList()
    }
}