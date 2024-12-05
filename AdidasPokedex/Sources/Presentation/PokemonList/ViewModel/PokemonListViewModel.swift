//
//  PokemonListViewModel.swift
//  PokeApiProject
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import Foundation
import SwiftUI

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published private(set) var pokemons: [Pokemon] = []
    @Published private(set) var filteredPokemons: [Pokemon] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    @Published var selectedGeneration: PokemonGeneration = .all
    @Published var selectedSortType: SortType = .id
    @Published var selectedSortOrder: SortOrder = .ascending
    
    private let fetchPokemonListUseCase: FetchPokemonListUseCase
    private let filterPokemonUseCase: FilterPokemonUseCase
    
    init(fetchPokemonListUseCase: FetchPokemonListUseCase,
         filterPokemonUseCase: FilterPokemonUseCase) {
        self.fetchPokemonListUseCase = fetchPokemonListUseCase
        self.filterPokemonUseCase = filterPokemonUseCase
    }
    
    func loadPokemonList() async {
        isLoading = true
        error = nil
        
        do {
            pokemons = try await fetchPokemonListUseCase.execute()
            applyFilters()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func applyFilters() {
        filteredPokemons = filterPokemonUseCase.execute(
            pokemons: pokemons,
            generation: selectedGeneration,
            sortType: selectedSortType,
            sortOrder: selectedSortOrder
        )
    }
    
    func updateGeneration(_ generation: PokemonGeneration) {
        selectedGeneration = generation
        applyFilters()
    }
    
    func updateSortType(_ sortType: SortType) {
        selectedSortType = sortType
        applyFilters()
    }
    
    func toggleSortOrder() {
        selectedSortOrder = selectedSortOrder == .ascending ? .descending : .ascending
        applyFilters()
    }
}
