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
