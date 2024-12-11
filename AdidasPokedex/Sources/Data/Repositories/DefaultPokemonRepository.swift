//
//  DefaultPokemonRepository.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

final class DefaultPokemonRepository: PokemonRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // Fetch and decode to DTO then convert to domain model
    func fetchPokemonList() async throws -> [Pokemon] {
        let response: PokemonListResponseDTO = try await networkService.fetch(from: .pokemonList())
        return response.toDomain()
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let dto: PokemonDetailDTO = try await networkService.fetch(from: .pokemonDetail(id: id))
        return dto.toDomain()
    }
}
