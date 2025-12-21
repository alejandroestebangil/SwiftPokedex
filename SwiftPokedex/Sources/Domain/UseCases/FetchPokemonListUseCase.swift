import Foundation
import Dependencies

protocol FetchPokemonListUseCase {
    func execute() async throws -> [Pokemon]
}

final class DefaultFetchPokemonListUseCase: FetchPokemonListUseCase {
    @Dependency(\.pokemonRepository) private var repository
    
    func execute() async throws -> [Pokemon] {
        return try await repository.fetchPokemonList()
    }
}
