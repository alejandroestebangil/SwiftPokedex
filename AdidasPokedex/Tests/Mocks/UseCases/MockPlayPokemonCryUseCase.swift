//
//  MockPlayPokemonCryUseCase.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import Foundation
@testable import AdidasPokedex

class MockPlayPokemonCryUseCase: PlayPokemonCryUseCase {
    var executeResult: Result<Void, Error> = .success(())
    var executedPokemonName: String?
    
    func execute(pokemonName: String) async throws {
        executedPokemonName = pokemonName
        try executeResult.get()
    }
}
