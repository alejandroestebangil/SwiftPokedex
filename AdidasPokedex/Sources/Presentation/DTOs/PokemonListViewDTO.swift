//
//  PokemonListViewDTO.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 11/12/24.
//

struct PokemonListViewDTO: Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    
    init(pokemon: Pokemon) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
    }
}
