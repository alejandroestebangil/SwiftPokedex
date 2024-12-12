//
//  PokemonDetailViewDTO.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 11/12/24.
//

struct PokemonDetailViewDTO: Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let types: [String]
    let height: Double
    let weight: Double
    let baseStats: [StatDTO]
    
    struct StatDTO: Identifiable {
        let id: Int
        let name: String
        let value: Int
        
        init(id: Int, name: String, value: Int) {
            self.id = id // Using an id even though stats are unique
            self.name = name
            self.value = value
        }
    }
    
    init(pokemon: PokemonDetail) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
        self.types = pokemon.types
        self.height = pokemon.height
        self.weight = pokemon.weight
        self.baseStats = pokemon.baseStats.enumerated().map { index, stat in
            StatDTO(id: index, name: stat.name, value: stat.value)
        }
    }
}
