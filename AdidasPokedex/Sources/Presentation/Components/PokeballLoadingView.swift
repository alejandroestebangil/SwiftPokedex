//
//  PokeballLoadingView.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//

import SwiftUI

struct PokeballLoadingView: View {
    @State private var isRotating = false
    
    var body: some View {
        VStack {
            Image("pokeball-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(
                    .linear(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: isRotating
                )
                .onAppear {
                    isRotating = true
                }
        }
    }
}


