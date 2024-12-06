//
//  PokemonHeader.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 6/12/24.
//


import SwiftUI

struct PokemonHeader: View {
    let onTap: () -> Void
    
    var body: some View {
        Rectangle()
            .fill(Color(.systemBlue))
            .frame(height: 90)
            .overlay(
                HStack(spacing: 12) {
                    Image("pokedex-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                    
                    Image("pokeball-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                }
            )
            .shadow(radius: 3)
            .onTapGesture(perform: onTap)
    }
}