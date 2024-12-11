//
//  FetchPokemonDetailUseCase.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//


protocol FetchPokemonDetailUseCase {
    func execute(id: Int) async throws -> PokemonDetail
}

final class DefaultFetchPokemonDetailUseCase: FetchPokemonDetailUseCase {
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> PokemonDetail {
        try await repository.fetchPokemonDetail(id: id)
    }
}