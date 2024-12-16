//
//  PokemonDetailViewModel.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//


import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published private(set) var pokemonDetail: PokemonDetailViewDTO?
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    @Published private(set) var isPlayingCry = false
    
    private let pokemonId: Int
    private let fetchPokemonDetailUseCase: FetchPokemonDetailUseCase
    private let audioService: PokemonAudioServiceProtocol
    
    init(pokemonId: Int,
         fetchPokemonDetailUseCase: FetchPokemonDetailUseCase,
         audioService: PokemonAudioServiceProtocol = PokemonAudioService()
    ) {
        self.pokemonId = pokemonId
        self.fetchPokemonDetailUseCase = fetchPokemonDetailUseCase
        self.audioService = audioService
    }
    
    func loadPokemonDetail() async {
        isLoading = true
        error = nil
        
        do {
            let detail = try await fetchPokemonDetailUseCase.execute(id: pokemonId)
            pokemonDetail = PokemonDetailViewDTO(pokemon: detail)
        } catch {
            print("Error loading pokemon:", error.localizedDescription)
            self.error = error
        }
        
        isLoading = false
    }
    
    func playPokemonCry() {
        Task {
            isPlayingCry = true
            do {
                try await audioService.playPokemonCry(for: pokemonId)
            } catch {
                // Handle error if needed
                print("Error playing cry:", error)
            }
            isPlayingCry = false
        }
    }
}
