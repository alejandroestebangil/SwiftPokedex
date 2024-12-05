//
//  PokemonListView.swift
//  PokeApiProject
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel: PokemonListViewModel
    private let pokemonRepository: PokemonRepository
    
    init(viewModel: PokemonListViewModel, pokemonRepository: PokemonRepository) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.pokemonRepository = pokemonRepository
        
        // Title bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 36, weight: .bold)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                filterBar
                
                Group {
                    if viewModel.isLoading {
                        LoadingView()
                    } else {
                        pokemonList
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack(spacing: 12) {
                            Image("pokedex-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                                .padding(.bottom, 15)
                                .padding(.top, 10)
                            
                            Image("pokeball-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .padding(.vertical, 10)
                        }
                        .padding(.vertical, 42)
                        .frame(maxWidth: .infinity)
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
    
    private var filterBar: some View {
        HStack(spacing: 16) {
            // Generation Picker
            Menu {
                ForEach(PokemonGeneration.allCases, id: \.self) { generation in
                    Button(action: {
                        viewModel.updateGeneration(generation)
                    }) {
                        if generation == viewModel.selectedGeneration {
                            Label(generation.displayName, systemImage: "checkmark")
                        } else {
                            Text(generation.displayName)
                        }
                    }
                }
            } label: {
                Label(viewModel.selectedGeneration.displayName, systemImage: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            // Sort Type Menu
            Menu {
                Button(action: { viewModel.updateSortType(.id) }) {
                    if viewModel.selectedSortType == .id {
                        Label("Number", systemImage: "checkmark")
                    } else {
                        Text("Number")
                    }
                }
                
                Button(action: { viewModel.updateSortType(.name) }) {
                    if viewModel.selectedSortType == .name {
                        Label("Name", systemImage: "checkmark")
                    } else {
                        Text("Name")
                    }
                }
            } label: {
                Label(viewModel.selectedSortType.displayName, systemImage: "slider.horizontal.3")
                    .foregroundColor(.primary)
            }
            
            // Sort Order Button
            Button(action: {
                viewModel.toggleSortOrder()
            }) {
                Image(systemName: viewModel.selectedSortOrder.systemImage)
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .shadow(radius: 1)
    }
    
    private var pokemonList: some View {
        List(viewModel.filteredPokemons) { pokemon in
            ZStack {
                NavigationLink {
                    Text("Pokemon Detail: \(pokemon.name)")
                } label: {
                    EmptyView()
                }
                .opacity(0)
                
                PokemonRowView(pokemon: pokemon)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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
    let pokemon: Pokemon
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
