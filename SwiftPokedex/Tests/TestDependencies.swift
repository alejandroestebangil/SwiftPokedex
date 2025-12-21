import Dependencies
import XCTest
@testable import SwiftPokedex

// Common test helper
extension DependencyValues {
    mutating func registerTestDependencies(
        networkService: NetworkService = MockNetworkService(),
        persistenceController: PersistenceController = PersistenceController(),
        repository: PokemonRepository = MockPokemonRepository(),
        fetchListUseCase: FetchPokemonListUseCase = MockFetchPokemonListUseCase(),
        filterPokemonUseCase: FilterPokemonUseCase = MockFilterPokemonUseCase(),
        fetchDetailUseCase: FetchPokemonDetailUseCase = MockFetchPokemonDetailUseCase(),
        audioService: PokemonAudioServiceProtocol = MockPokemonAudioService()
    ) {
        self.networkService = networkService
        self.persistenceController = persistenceController
        self.pokemonRepository = repository
        self.fetchPokemonListUseCase = fetchListUseCase
        self.filterPokemonUseCase = filterPokemonUseCase
        self.fetchPokemonDetailUseCase = fetchDetailUseCase
        self.audioService = audioService
    }
}
