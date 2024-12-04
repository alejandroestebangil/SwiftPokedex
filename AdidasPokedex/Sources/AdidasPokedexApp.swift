import SwiftUI

@main
struct AdidasPokedexApp: App {
    // Create all dependencies at the app level
    private let networkService = DefaultNetworkService()
    private let repository: PokemonRepository
    private let pokemonListViewModel: PokemonListViewModel
    
    init() {
        // Initialize repository
        repository = DefaultPokemonRepository(
            networkService: networkService
        )
        
        // Initialize view model
        pokemonListViewModel = PokemonListViewModel(
            fetchPokemonListUseCase: DefaultFetchPokemonListUseCase(
                repository: repository
            )
        )
    }
    
    var body: some Scene {
        WindowGroup {
            PokemonListView(
                viewModel: pokemonListViewModel,
                pokemonRepository: repository
            )
        }
    }
}
