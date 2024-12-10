//
//  APIEndpoint.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

enum APIEndpoint {
    static let totalPokemons: Int = 1025
    case pokemonList(limit: Int = totalPokemons)
    case pokemonDetail(id: Int)
    
    var url: URL? {
        switch self {
        case .pokemonList(let limit):
            return URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)")
        
        // Case added pending the implementation of de PokemonDetailsPage
        case .pokemonDetail(let id):
            return URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        }
    }
}
