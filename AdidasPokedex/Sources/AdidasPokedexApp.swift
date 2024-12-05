import SwiftUI

@main
struct AdidasPokedexApp: App {
    // Create all dependencies at the app level
    private let networkService = DefaultNetworkService()
    private let repository: PokemonRepository
    private let filterUseCase: FilterPokemonUseCase
    private let pokemonListViewModel: PokemonListViewModel
    
    init() {
        // Initialize repository
        repository = DefaultPokemonRepository(
            networkService: networkService
        )
        
        // Initialize filter use case
        filterUseCase = DefaultFilterPokemonUseCase()
        
        // Initialize view model with the use cases
        pokemonListViewModel = PokemonListViewModel(
            fetchPokemonListUseCase: DefaultFetchPokemonListUseCase(
                repository: repository
            ),
            filterPokemonUseCase: filterUseCase
        )
    }
    
    var body: some Scene {
        WindowGroup {
            PokemonListView(
                viewModel: pokemonListViewModel
            )
        }
    }
}
