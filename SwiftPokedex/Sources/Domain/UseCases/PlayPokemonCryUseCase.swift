//
//  PlayPokemonCryUseCase.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 16/12/24.
//

protocol PlayPokemonCryUseCase {
    func execute(pokemonName: String) async throws
}

final class DefaultPlayPokemonCryUseCase: PlayPokemonCryUseCase {
    private let audioService: PokemonAudioServiceProtocol
    
    init(audioService: PokemonAudioServiceProtocol) {
        self.audioService = audioService
    }
    
    func execute(pokemonName: String) async throws {
        try await audioService.playPokemonCry(for: pokemonName)
    }
}
