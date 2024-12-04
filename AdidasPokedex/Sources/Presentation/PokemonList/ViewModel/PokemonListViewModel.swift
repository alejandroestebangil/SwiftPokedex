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
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let fetchPokemonListUseCase: FetchPokemonListUseCase
    
    init(fetchPokemonListUseCase: FetchPokemonListUseCase) {
        self.fetchPokemonListUseCase = fetchPokemonListUseCase
    }
    
    func loadPokemonList() async {
        isLoading = true
        error = nil
        
        do {
            pokemons = try await fetchPokemonListUseCase.execute()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}