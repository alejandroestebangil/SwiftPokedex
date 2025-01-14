//
//  FetchPokemonDetailUseCase.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//

import Foundation
import Dependencies

protocol FetchPokemonDetailUseCase {
    func execute(id: Int) async throws -> PokemonDetail
}

final class DefaultFetchPokemonDetailUseCase: FetchPokemonDetailUseCase {
    @Dependency(\.pokemonRepository) private var repository
    
    func execute(id: Int) async throws -> PokemonDetail {
        try await repository.fetchPokemonDetail(id: id)
    }
}
