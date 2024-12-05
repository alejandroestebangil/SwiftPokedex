//
//  APIEndpoint.swift
//  PokeApiProject
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

enum APIEndpoint {
    // Limit at 151 just to show 1st gen for now and then implement the filter
    case pokemonList(limit: Int = 1025)
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
