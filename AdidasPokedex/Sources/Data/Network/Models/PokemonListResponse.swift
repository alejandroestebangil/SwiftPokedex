//
//  PokemonListResponse.swift
//  PokeApiProject
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}