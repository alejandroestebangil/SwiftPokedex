//
//  PokemonDetailView.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonId: Int, fetchPokemonDetailUseCase: FetchPokemonDetailUseCase) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(
            pokemonId: pokemonId,
            fetchPokemonDetailUseCase: fetchPokemonDetailUseCase
        ))
    }
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                PokeballLoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 170)
            } else if let pokemon = viewModel.pokemonDetail {
                VStack(spacing: 24) {
                    
                    // Image, Name and Id
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 200, height: 200)
                        }
                        
                        VStack(spacing: 8) {
                            Text(pokemon.name.capitalized)
                                .font(.title)
                                .bold()
                            
                            Text("#\(String(format: "%04d", pokemon.id))")
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Types
                    HStack(spacing: 16) {
                        ForEach(pokemon.types, id: \.self) { type in
                            Text(type.capitalized)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(typeColor(for: type))
                                .cornerRadius(12)
                        }
                    }
                    
                    // Physical Stats Card
                    VStack(spacing: 16) {
                        HStack(spacing: 40) {
                            VStack(spacing: 4) {
                                Text("Height")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f m", pokemon.height))
                                    .font(.title3)
                                    .bold()
                            }
                            
                            VStack(spacing: 4) {
                                Text("Weight")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f kg", pokemon.weight))
                                    .font(.title3)
                                    .bold()
                            }
                        }
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Stats Card
                    VStack(alignment: .leading, spacing: 16) {
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
                                            .frame(height: 6)
                                            .cornerRadius(3)
                                        
                                        Rectangle()
                                            .fill(statColor(value: stat.value))
                                            .frame(width: geometry.size.width * CGFloat(stat.value) / 181.0, height: 6)
                                            .cornerRadius(3)
                                    }
                                }
                                .frame(height: 6)
                            }
                        }
                    }
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
                .padding()
            }
        }
        .background(Color(.systemGray6))
        .task {
            await viewModel.loadPokemonDetail()
        }
    }
    
    private func typeColor(for type: String) -> Color {
        switch type.lowercased() {
        case "normal": return Color(.systemGray)
        case "fighting": return Color(.systemRed)
        case "flying": return Color(.systemBlue)
        case "poison": return .purple
        case "ground": return .brown
        case "rock": return .brown
        case "bug": return .green
        case "ghost": return .purple
        case "steel": return Color(.systemGray)
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "psychic": return .pink
        case "ice": return Color(.systemTeal)
        case "dragon": return .purple
        case "dark": return Color(.darkGray)
        case "fairy": return .pink
        default: return Color(.systemGray)
        }
    }
    
    private func statColor(value: Int) -> Color {
        if value < 60 {
            return .red
        } else if value < 90 {
            return .orange
        } else if value < 120 {
            return .green
        } else {
            return .indigo
        }
    }
    
    private func statName(_ name: String) -> String {
        switch name {
        case "hp": return "HP"
        case "attack": return "Attack"
        case "defense": return "Defense"
        case "special-attack": return "Special Attack"
        case "special-defense": return "Special Defense"
        case "speed": return "Speed"
        default: return name.capitalized
        }
    }
}
