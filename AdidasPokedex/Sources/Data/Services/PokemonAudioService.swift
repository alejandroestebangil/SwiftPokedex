//
//  PokemonAudioService.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 16/12/24.
//

import AVFoundation

protocol PokemonAudioServiceProtocol {
    func playPokemonCry(for id: Int) async throws
}

class PokemonAudioService: PokemonAudioServiceProtocol {
    private var audioPlayer: AVAudioPlayer?
    
    func playPokemonCry(for id: Int) async throws {
        let formattedId = String(format: "%03d", id)
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/\(id).ogg") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        audioPlayer = try AVAudioPlayer(data: data)
        audioPlayer?.play()
    }
}
