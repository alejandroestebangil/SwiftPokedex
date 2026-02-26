import XCTest
import ComposableArchitecture
@testable import SwiftPokedex

@MainActor
final class PokemonListFeatureTests: XCTestCase {

    func test_onAppear_whenFetchSucceeds_shouldLoadPokemonList() async {
        // Given
        let pokemon = Pokemon.fixture()
        let fetchStub = FetchPokemonListUseCaseStub()
        fetchStub.executeToBeReturned = .success([pokemon])
        let filterStub = FilterPokemonUseCaseStub()
        filterStub.executeToBeReturned = [pokemon]

        let store = TestStore(initialState: PokemonListFeature.State()) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.fetchPokemonListUseCase = fetchStub
            deps.filterPokemonUseCase = filterStub
        }

        // When
        await store.send(.onAppear) {
            $0.isLoading = true
        }

        // Then
        await store.receive(.pokemonListResponse(TaskResult<[Pokemon]> { [pokemon] })) {
            $0.isLoading = false
            $0.pokemons = [pokemon]
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_onAppear_whenFetchFails_shouldSetError() async {
        // Given
        let fetchStub = FetchPokemonListUseCaseStub()
        fetchStub.executeToBeReturned = .failure(TestError.someError)

        let store = TestStore(initialState: PokemonListFeature.State()) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.fetchPokemonListUseCase = fetchStub
        }

        // When
        await store.send(.onAppear) {
            $0.isLoading = true
        }

        // Then
        await store.receive(.pokemonListResponse(TaskResult<[Pokemon]> { throw TestError.someError })) {
            $0.isLoading = false
            $0.error = TestError.someError.localizedDescription
        }
    }

    func test_onAppear_whenAlreadyLoading_shouldNotTriggerFetch() async {
        // Given
        var state = PokemonListFeature.State()
        state.isLoading = true

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        }

        // When / Then
        await store.send(.onAppear)
    }

    func test_updateGeneration_whenGenerationChanges_shouldFilterPokemons() async {
        // Given
        let pokemon = Pokemon.fixture()
        let filterStub = FilterPokemonUseCaseStub()
        filterStub.executeToBeReturned = [pokemon]

        var state = PokemonListFeature.State()
        state.pokemons = [pokemon]

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.filterPokemonUseCase = filterStub
        }

        // When / Then
        await store.send(.updateGeneration(.gen1)) {
            $0.selectedGeneration = .gen1
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_updateSortType_whenSortTypeChanges_shouldFilterPokemons() async {
        // Given
        let pokemon = Pokemon.fixture()
        let filterStub = FilterPokemonUseCaseStub()
        filterStub.executeToBeReturned = [pokemon]

        var state = PokemonListFeature.State()
        state.pokemons = [pokemon]

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.filterPokemonUseCase = filterStub
        }

        // When / Then
        await store.send(.updateSortType(.name)) {
            $0.selectedSortType = .name
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_toggleSortOrder_whenToggled_shouldReverseOrder() async {
        // Given
        let pokemon = Pokemon.fixture()
        let filterStub = FilterPokemonUseCaseStub()
        filterStub.executeToBeReturned = [pokemon]

        var state = PokemonListFeature.State()
        state.pokemons = [pokemon]

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.filterPokemonUseCase = filterStub
        }

        // When / Then
        await store.send(.toggleSortOrder) {
            $0.selectedSortOrder = .descending
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_pokemonTapped_shouldSetDestination() async {
        // Given
        let store = TestStore(initialState: PokemonListFeature.State()) {
            PokemonListFeature()
        }

        // When / Then
        await store.send(.pokemonTapped(id: 25)) {
            $0.destination = PokemonDetailViewFeature.State(pokemonId: 25)
        }
    }

    func test_dismissError_shouldClearErrorState() async {
        // Given
        var state = PokemonListFeature.State()
        state.error = "Something went wrong"

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        }

        // When / Then
        await store.send(.dismissError) {
            $0.error = nil
        }
    }
}
