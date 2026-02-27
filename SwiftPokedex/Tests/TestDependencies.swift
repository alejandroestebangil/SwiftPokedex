import Dependencies
import XCTest
@testable import SwiftPokedex

extension DependencyValues {
    /// Overrides all dependencies with test doubles in one call.
    /// Every dependency has a default stub/mock so tests only need to
    /// override the ones they care about.
    mutating func registerTestDependencies(
        networkService: NetworkService = NetworkServiceStub(),
        persistenceController: PersistenceController = PersistenceController(),
        repository: PokemonRepository = PokemonRepositoryStub(),
        fetchListUseCase: FetchPokemonListUseCase = FetchPokemonListUseCaseStub(),
        filterPokemonUseCase: FilterPokemonUseCase = FilterPokemonUseCaseStub(),
        fetchDetailUseCase: FetchPokemonDetailUseCase = FetchPokemonDetailUseCaseStub(),
        playPokemonCryUseCase: PlayPokemonCryUseCase = PlayPokemonCryUseCaseMock(),
        audioService: PokemonAudioServiceProtocol = PokemonAudioServiceMock()
    ) {
        self.networkService = networkService
        self.persistenceController = persistenceController
        self.pokemonRepository = repository
        self.fetchPokemonListUseCase = fetchListUseCase
        self.filterPokemonUseCase = filterPokemonUseCase
        self.fetchPokemonDetailUseCase = fetchDetailUseCase
        self.playPokemonCryUseCase = playPokemonCryUseCase
        self.audioService = audioService
    }
}
