//
//  PokemonListView.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel
    private let fetchPokemonDetailUseCase: FetchPokemonDetailUseCase
    private let playPokemonCryUseCase: PlayPokemonCryUseCase
    
    init(viewModel: PokemonListViewModel,
         fetchPokemonDetailUseCase: FetchPokemonDetailUseCase,
         playPokemonCryUseCase: PlayPokemonCryUseCase) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.fetchPokemonDetailUseCase = fetchPokemonDetailUseCase
        self.playPokemonCryUseCase = playPokemonCryUseCase
    }
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    PokemonHeader {
                        withAnimation {
                            proxy.scrollTo("top", anchor: .top)
                            // Return to top clicking header
                        }
                    }
                    
                    FilterBar(viewModel: viewModel)
                    
                    Group {
                        if viewModel.isLoading {
                            LoadingView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            pokemonList()
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    private func pokemonList() -> some View {
        List {
            ForEach(viewModel.filteredPokemons) { pokemon in
                NavigationLink {
                    PokemonDetailView(
                        pokemonId: pokemon.id,
                        fetchPokemonDetailUseCase: fetchPokemonDetailUseCase,
                        playPokemonCryUseCase: playPokemonCryUseCase
                    )
                } label: {
                    PokemonRowView(pokemon: pokemon)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .id(viewModel.filteredPokemons.first?.id == pokemon.id ? "top" : nil)
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
        }
    }
}
