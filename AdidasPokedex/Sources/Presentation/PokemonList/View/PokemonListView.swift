//
//  PokemonListView.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel
    
    init(viewModel: PokemonListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    PokemonHeader {
                        withAnimation {
                            proxy.scrollTo("top", anchor: .top)
                        }
                    }
                    
                    FilterBar(viewModel: viewModel)
                    
                    Group {
                        if viewModel.isLoading {
                            LoadingView()
                        } else {
                            pokemonList(proxy: proxy)
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                    .task {
                        await viewModel.loadPokemonList()
                    }
                    .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text(viewModel.error?.localizedDescription ?? "Unknown error")
                    }
                }
            }
        }
    }
    
    private func pokemonList(proxy: ScrollViewProxy) -> some View {
        List {
            ForEach(viewModel.filteredPokemons) { pokemon in
                NavigationLink {
                    Text("Pokemon Detail: \(pokemon.name)")
                } label: {
                    PokemonRowView(pokemon: pokemon)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .id(viewModel.filteredPokemons.first?.id == pokemon.id ? "top" : nil) // First pokemon of the list
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading Pokémon...")
                .foregroundColor(.secondary)
        }
    }
}

struct PokemonRowView: View {
    let pokemon: Pokemon // FIX WITH DTO
    @State private var isFavorite = false
    
    var body: some View {
        HStack(spacing: 16) {
            HStack {
                AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                Text(pokemon.id.description.capitalized + " -")
                    .font(.headline)
                Text(pokemon.name.capitalized)
                    .font(.headline)
            }
            
            Spacer(minLength: 0)
            
            // Favorite button
            Button(action: {
                isFavorite.toggle()
                // TODO: Add favorite functionality
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
    }
}
