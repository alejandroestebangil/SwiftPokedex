import Foundation
import Dependencies

/// Fetches a single Pokémon's detail (stats, types, height/weight) by ID.
protocol FetchPokemonDetailUseCase {
    func execute(id: Int) async throws -> PokemonDetail
}

final class DefaultFetchPokemonDetailUseCase: FetchPokemonDetailUseCase {
    @Dependency(\.pokemonRepository) private var repository
    
    func execute(id: Int) async throws -> PokemonDetail {
        try await repository.fetchPokemonDetail(id: id)
    }
}
