//
//  MockPokemonAudioService.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//


import Foundation
@testable import AdidasPokedex

class MockPokemonAudioService: PokemonAudioServiceProtocol {
    var playResult: Result<Void, Error> = .success(())
    var playedPokemonName: String?
    
    func playPokemonCry(for name: String) async throws {
        playedPokemonName = name
        try playResult.get()
    }
}