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
    private let playPokemonCryUseCase: PlayPokemonCryUseCase
    
    init(pokemonId: Int,
         fetchPokemonDetailUseCase: FetchPokemonDetailUseCase,
         playPokemonCryUseCase: PlayPokemonCryUseCase) {
        self.pokemonId = pokemonId
        self.fetchPokemonDetailUseCase = fetchPokemonDetailUseCase
        self.playPokemonCryUseCase = playPokemonCryUseCase
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
        guard let pokemonName = pokemonDetail?.name else { return }
        Task {
            isPlayingCry = true
            do {
                try await playPokemonCryUseCase.execute(pokemonName: pokemonName)
            } catch {
                print("Error playing cry:", error)
            }
            isPlayingCry = false
        }
    }
}
