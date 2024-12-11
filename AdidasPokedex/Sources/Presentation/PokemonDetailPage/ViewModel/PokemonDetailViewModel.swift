import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published private(set) var pokemonDetail: PokemonDetail?
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let pokemonId: Int
    private let repository: PokemonRepository
    
    init(pokemonId: Int, repository: PokemonRepository) {
        self.pokemonId = pokemonId
        self.repository = repository
    }
    
    func loadPokemonDetail() async {
        isLoading = true
        error = nil
        
        do {
            let detail = try await repository.fetchPokemon(id: pokemonId)
            pokemonDetail = detail
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}