//
//  PokemonRowView.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: PokemonListViewDTO
    
    init(pokemon: PokemonListViewDTO) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        HStack(spacing: 16) {
            HStack {
                PokemonAsyncImage(url: pokemon.imageUrl, size: 66)
                
                Text("#\(String(format: "%04d", pokemon.id)) -")
                    .font(.title3)
                    .bold()
                Text(pokemon.name.capitalized)
                    .font(.title3)
                    .bold()
            }
        }
        .padding(.vertical, 8)
    }
}
