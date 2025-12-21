import Foundation

protocol PokemonRepository {
    func fetchPokemonList() async throws -> [Pokemon]
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail
}
