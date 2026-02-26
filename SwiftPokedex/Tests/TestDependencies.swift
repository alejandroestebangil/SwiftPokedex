import Dependencies
import XCTest
@testable import SwiftPokedex

extension DependencyValues {
    mutating func registerTestDependencies(
        networkService: NetworkService = NetworkServiceStub(),
        persistenceController: PersistenceController = PersistenceController(),
        repository: PokemonRepository = PokemonRepositoryStub(),
        fetchListUseCase: FetchPokemonListUseCase = FetchPokemonListUseCaseStub(),
        filterPokemonUseCase: FilterPokemonUseCase = FilterPokemonUseCaseStub(),
        fetchDetailUseCase: FetchPokemonDetailUseCase = FetchPokemonDetailUseCaseStub(),
        audioService: PokemonAudioServiceProtocol = PokemonAudioServiceMock()
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
