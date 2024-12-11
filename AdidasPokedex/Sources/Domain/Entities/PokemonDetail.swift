//
//  PokemonDetail.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//


import Foundation

struct PokemonDetail: Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let types: [String]
    let weight: Double
    let height: Double
    let baseStats: [Stat]
    
    struct Stat {
        let name: String
        let value: Int
    }
}