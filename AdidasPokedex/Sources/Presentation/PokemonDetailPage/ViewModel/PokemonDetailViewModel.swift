//
//  PokemonDetailViewModel.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//


import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published private(set) var pokemonDetail: PokemonDetail?
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let pokemonId: Int
    private let fetchPokemonDetailUseCase: FetchPokemonDetailUseCase
    
    init(pokemonId: Int, fetchPokemonDetailUseCase: FetchPokemonDetailUseCase) {
        self.pokemonId = pokemonId
        self.fetchPokemonDetailUseCase = fetchPokemonDetailUseCase
    }
    
    func loadPokemonDetail() async {
        isLoading = true
        error = nil
        
        do {
            pokemonDetail = try await fetchPokemonDetailUseCase.execute(id: pokemonId)
        } catch {
            print("Error loading pokemon:", error.localizedDescription)
            self.error = error
        }
        
        isLoading = false
    }
}
