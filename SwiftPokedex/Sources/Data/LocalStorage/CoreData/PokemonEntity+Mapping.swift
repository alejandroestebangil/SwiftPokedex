//
//  PokemonEntity+Mapping.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 18/12/24.
//

import CoreData

extension PokemonEntity {
    func toDomain() -> Pokemon {
        Pokemon(
            id: Int(id),
            name: name ?? "",
            imageUrl: imageUrl ?? ""
        )
    }
    
    func update(from pokemon: Pokemon) {
        self.id = Int64(pokemon.id)
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
    }
}
