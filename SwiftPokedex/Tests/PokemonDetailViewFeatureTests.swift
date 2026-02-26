import XCTest
import ComposableArchitecture
@testable import SwiftPokedex

@MainActor
final class PokemonDetailViewFeatureTests: XCTestCase {

    func test_onAppear_whenFetchSucceeds_shouldLoadPokemonDetail() async {
        // Given
        let pokemon = PokemonDetail.fixture()
        let fetchStub = FetchPokemonDetailUseCaseStub()
        fetchStub.executeToBeReturned = .success(pokemon)

        let store = TestStore(initialState: PokemonDetailViewFeature.State(pokemonId: 1)) {
            PokemonDetailViewFeature()
        } withDependencies: { deps in
            deps.fetchPokemonDetailUseCase = fetchStub
        }

        // When
        await store.send(.onAppear) {
            $0.isLoading = true
        }

        // Then
        await store.receive(.pokemonDetailResponse(TaskResult<PokemonDetail> { pokemon })) {
            $0.isLoading = false
            $0.pokemonDetail = PokemonDetailViewDTO(pokemon: pokemon)
        }
    }

    func test_onAppear_whenFetchFails_shouldSetError() async {
        // Given
        let fetchStub = FetchPokemonDetailUseCaseStub()
        fetchStub.executeToBeReturned = .failure(TestError.someError)

        let store = TestStore(initialState: PokemonDetailViewFeature.State(pokemonId: 1)) {
            PokemonDetailViewFeature()
        } withDependencies: { deps in
            deps.fetchPokemonDetailUseCase = fetchStub
        }

        // When
        await store.send(.onAppear) {
            $0.isLoading = true
        }

        // Then
        await store.receive(.pokemonDetailResponse(TaskResult<PokemonDetail> { throw TestError.someError })) {
            $0.isLoading = false
            $0.error = TestError.someError.localizedDescription
        }
    }

    func test_playCry_whenCrySucceeds_shouldSetIsPlayingCryFalse() async {
        // Given
        let pokemon = PokemonDetail.fixture()
        let playCryMock = PlayPokemonCryUseCaseMock()
        playCryMock.executeToBeReturned = .success(())

        var state = PokemonDetailViewFeature.State(pokemonId: 1)
        state.pokemonDetail = PokemonDetailViewDTO(pokemon: pokemon)

        let store = TestStore(initialState: state) {
            PokemonDetailViewFeature()
        } withDependencies: { deps in
            deps.playPokemonCryUseCase = playCryMock
        }

        // When
        await store.send(.playCry) {
            $0.isPlayingCry = true
        }

        // Then
        await store.receive(.playCryResponse(TaskResult<Void> { })) {
            $0.isPlayingCry = false
        }
    }

    func test_playCry_whenCryFails_shouldSetError() async {
        // Given
        let pokemon = PokemonDetail.fixture()
        let playCryMock = PlayPokemonCryUseCaseMock()
        playCryMock.executeToBeReturned = .failure(TestError.someError)

        var state = PokemonDetailViewFeature.State(pokemonId: 1)
        state.pokemonDetail = PokemonDetailViewDTO(pokemon: pokemon)

        let store = TestStore(initialState: state) {
            PokemonDetailViewFeature()
        } withDependencies: { deps in
            deps.playPokemonCryUseCase = playCryMock
        }

        // When
        await store.send(.playCry) {
            $0.isPlayingCry = true
        }

        // Then
        await store.receive(.playCryResponse(TaskResult<Void> { throw TestError.someError })) {
            $0.isPlayingCry = false
            $0.error = TestError.someError.localizedDescription
        }
    }
}
