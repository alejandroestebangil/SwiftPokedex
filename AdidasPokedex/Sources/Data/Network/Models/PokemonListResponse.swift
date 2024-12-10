//
//  PokemonListResponse.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
    
    // Take Pokemon Id from URL
    var id: Int {
        guard let idString = url.split(separator: "/").last else { return 0 }
        return Int(idString) ?? 0
    }
}
