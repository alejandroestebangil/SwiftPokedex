import Foundation

/// Domain-layer contract for Pokémon data access.
/// Implemented by `DefaultPokemonRepository` in the Data layer.
protocol PokemonRepository {
    func fetchPokemonList() async throws -> [Pokemon]
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail
}
