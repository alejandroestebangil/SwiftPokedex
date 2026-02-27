import Foundation
import Dependencies

/// Fetches the full Pokémon list from the repository (API-first, CoreData fallback).
protocol FetchPokemonListUseCase {
    func execute() async throws -> [Pokemon]
}

final class DefaultFetchPokemonListUseCase: FetchPokemonListUseCase {
    @Dependency(\.pokemonRepository) private var repository
    
    func execute() async throws -> [Pokemon] {
        return try await repository.fetchPokemonList()
    }
}
