import XCTest
import ComposableArchitecture
@testable import SwiftPokedex

@MainActor
final class PokemonListFeatureTests: XCTestCase {

    func test_onAppear_success() async {
        let pokemon = Pokemon(id: 1, name: "bulbasaur", imageUrl: "url")
        let mockFetchListUseCase = MockFetchPokemonListUseCase()
        mockFetchListUseCase.result = .success([pokemon])
        let mockFilterUseCase = MockFilterPokemonUseCase()
        mockFilterUseCase.filterResult = [pokemon]

        let store = TestStore(initialState: PokemonListFeature.State()) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.fetchPokemonListUseCase = mockFetchListUseCase
            deps.filterPokemonUseCase = mockFilterUseCase
        }

        await store.send(.onAppear) {
            $0.isLoading = true
        }

        await store.receive(.pokemonListResponse(TaskResult<[Pokemon]> { [pokemon] })) {
            $0.isLoading = false
            $0.pokemons = [pokemon]
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_onAppear_failure() async {
        let mockFetchListUseCase = MockFetchPokemonListUseCase()
        mockFetchListUseCase.result = .failure(TestError.someError)

        let store = TestStore(initialState: PokemonListFeature.State()) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.fetchPokemonListUseCase = mockFetchListUseCase
        }

        await store.send(.onAppear) {
            $0.isLoading = true
        }

        await store.receive(.pokemonListResponse(TaskResult<[Pokemon]> { throw TestError.someError })) {
            $0.isLoading = false
            $0.error = TestError.someError.localizedDescription
        }
    }

    func test_onAppear_doesNotFetchWhenAlreadyLoading() async {
        var state = PokemonListFeature.State()
        state.isLoading = true

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        }

        await store.send(.onAppear)
    }

    func test_updateGeneration() async {
        let pokemon = Pokemon(id: 1, name: "bulbasaur", imageUrl: "url")
        let mockFilterUseCase = MockFilterPokemonUseCase()
        mockFilterUseCase.filterResult = [pokemon]

        var state = PokemonListFeature.State()
        state.pokemons = [pokemon]

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.filterPokemonUseCase = mockFilterUseCase
        }

        await store.send(.updateGeneration(.gen1)) {
            $0.selectedGeneration = .gen1
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_updateSortType() async {
        let pokemon = Pokemon(id: 1, name: "bulbasaur", imageUrl: "url")
        let mockFilterUseCase = MockFilterPokemonUseCase()
        mockFilterUseCase.filterResult = [pokemon]

        var state = PokemonListFeature.State()
        state.pokemons = [pokemon]

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.filterPokemonUseCase = mockFilterUseCase
        }

        await store.send(.updateSortType(.name)) {
            $0.selectedSortType = .name
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_toggleSortOrder() async {
        let pokemon = Pokemon(id: 1, name: "bulbasaur", imageUrl: "url")
        let mockFilterUseCase = MockFilterPokemonUseCase()
        mockFilterUseCase.filterResult = [pokemon]

        var state = PokemonListFeature.State()
        state.pokemons = [pokemon]

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        } withDependencies: { deps in
            deps.filterPokemonUseCase = mockFilterUseCase
        }

        await store.send(.toggleSortOrder) {
            $0.selectedSortOrder = .descending
            $0.filteredPokemons = [PokemonListViewDTO(pokemon: pokemon)]
        }
    }

    func test_pokemonTapped_setsDestination() async {
        let store = TestStore(initialState: PokemonListFeature.State()) {
            PokemonListFeature()
        }

        await store.send(.pokemonTapped(id: 25)) {
            $0.destination = PokemonDetailViewFeature.State(pokemonId: 25)
        }
    }

    func test_dismissError() async {
        var state = PokemonListFeature.State()
        state.error = "Something went wrong"

        let store = TestStore(initialState: state) {
            PokemonListFeature()
        }

        await store.send(.dismissError) {
            $0.error = nil
        }
    }
}
