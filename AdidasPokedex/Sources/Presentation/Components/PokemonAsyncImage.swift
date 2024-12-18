//
//  PokemonAsyncImage.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 18/12/24.
//

import SwiftUI

struct PokemonAsyncImage: View {
    let url: String?
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size, height: size)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image("pokeball-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
            @unknown default:
                Image("pokeball-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
            }
        }
        .frame(width: size, height: size)
    }
}
