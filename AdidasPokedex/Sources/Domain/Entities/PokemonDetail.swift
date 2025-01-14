//
//  PokemonDetail.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//


import Foundation

public struct PokemonDetail: Identifiable {
    public let id: Int
    public let name: String
    public let imageUrl: String
    public let types: [String]
    public let weight: Double
    public let height: Double
    public let baseStats: [Stat]
    
    public struct Stat {
        public let name: String
        public let value: Int
        
        public init(name: String, value: Int) {
            self.name = name
            self.value = value
        }
    }
    
    public init(id: Int, name: String, imageUrl: String, types: [String], weight: Double, height: Double, baseStats: [Stat]) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.types = types
        self.weight = weight
        self.height = height
        self.baseStats = baseStats
    }
}
