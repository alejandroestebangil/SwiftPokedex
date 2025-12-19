//
//  APIEndpoint.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import Foundation

enum APIEndpoint {
    case pokemonList(limit: Int = 1025)
    case pokemonDetail(id: Int)
    
    var url: URL? {
        switch self {
        case .pokemonList(let limit):
            return URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)")
        
        case .pokemonDetail(let id):
            return URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")
        }
    }
}
