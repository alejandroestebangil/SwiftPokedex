//
//  DefaultPokemonRepository.swift
//  PokeApiProject
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

final class DefaultPokemonRepository: PokemonRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList() async throws -> [Pokemon] {
        let response: PokemonListResponse = try await networkService.fetch(from: .pokemonList())
        let pokemons = response.results.enumerated().map { index, pokemon in
            Pokemon(
                id: index + 1,
                name: pokemon.name,
                imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(index + 1).png"
            )
        }
        return pokemons
    }
    
    // Added pending the implementation of de PokemonDetailsPage
    func fetchPokemon(id: Int) async throws -> Pokemon {
        return try await networkService.fetch(from: .pokemonDetail(id: id))
    }
}
