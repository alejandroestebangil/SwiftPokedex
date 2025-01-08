//
//  PokemonDetailView.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonId: Int) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemonId: pokemonId))
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                PokeballLoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 170)
            } else if let pokemon = viewModel.pokemonDetail {
                VStack(spacing: 24) {
                    VStack(spacing: Constants.spacingStacks) {
                        /// Image
                        Button {
                            viewModel.playPokemonCry()
                        } label: {
                            PokemonAsyncImage(url: pokemon.imageUrl, size: Constants.imageSize)
                             .overlay(alignment: .bottomTrailing) {
                                 if viewModel.isPlayingCry {
                                     ProgressView()
                                         .padding(Constants.cryButtonPadding)
                                         .background(.ultraThinMaterial)
                                         .cornerRadius(Constants.cryButtonRadius)
                                 } else {
                                     Image(systemName: "speaker.wave.2")
                                         .foregroundColor(.white)
                                         .padding(Constants.cryButtonPadding)
                                         .background(.ultraThinMaterial)
                                         .cornerRadius(Constants.cryButtonRadius)
                                 }
                             }
                        }
                    }
                    
                    /// Types
                    HStack(spacing: Constants.spacingStacks) {
                        ForEach(pokemon.types, id: \.self) { type in
                            Text(type.capitalized)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(typeColor(for: type))
                                .cornerRadius(Constants.statsCornerRadius)
                        }
                    }
                    
                    /// Height and Weight
                    VStack(spacing: Constants.spacingStacks) {
                        HStack(spacing: 40) {
                            VStack(spacing: Constants.spacingHeightWeight) {
                                Text("Height")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f m", pokemon.height))
                                    .font(.title3)
                                    .bold()
                            }
                            
                            VStack(spacing: Constants.spacingHeightWeight) {
                                Text("Weight")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f kg", pokemon.weight))
                                    .font(.title3)
                                    .bold()
                            }
                        }
                    }
                    .padding(Constants.statsPadding)
                    .background(Color(.systemBackground))
                    .cornerRadius(Constants.statsCornerRadius)
                    .shadow(radius: Constants.statsShadow)
                    
                    /// Stats
                    VStack(alignment: .leading, spacing: Constants.spacingStacks) {
                        Text("Base Stats")
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        ForEach(pokemon.baseStats, id: \.name) { stat in
                            VStack(spacing: 4) {
                                HStack {
                                    Text(statName(stat.name))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(stat.value)")
                                        .font(.subheadline)
                                        .bold()
                                }
                                
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .fill(Color(.systemGray5))
                                            .frame(height: Constants.statsBarHeight)
                                            .cornerRadius(Constants.statsBarRadius)
                                        
                                        Rectangle()
                                            .fill(statColor(value: stat.value))
                                            .frame(width: geometry.size.width * CGFloat(stat.value) / 181.0, height: Constants.statsBarHeight)
                                            .cornerRadius(Constants.statsBarRadius)
                                    }
                                }
                                .frame(height: 6)
                            }
                        }
                    }
                    .padding(Constants.statsPadding)
                    .background(Color(.systemBackground))
                    .cornerRadius(Constants.statsCornerRadius)
                    .shadow(radius: Constants.statsShadow)
                }
                .padding()
            }
        }
        .background(Color(.systemGray6))
        .task {
            await viewModel.loadPokemonDetail()
        }
    }
    
    private struct Constants {
        static let imageSize: CGFloat = 200
        static let cryButtonRadius: CGFloat = 10
        static let cryButtonPadding: CGFloat = 8
        static let spacingStacks: CGFloat = 16
        static let spacingHeightWeight: CGFloat = 4
        static let statsPadding: CGFloat = 20
        static let statsShadow: CGFloat = 2
        static let statsCornerRadius: CGFloat = 12
        static let statsBarHeight: CGFloat = 6
        static let statsBarRadius: CGFloat = 3
    }
}
