//
//  PokemonDetailViewFeatureTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 10/1/25.
//

import XCTest
import ComposableArchitecture
@testable import AdidasPokedex

@MainActor
final class PokemonDetailViewFeatureTests: XCTestCase {
    func test_onAppear_success() async {
        let pokemon = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: "url",
            types: ["grass"],
            weight: 6.9,
            height: 0.7,
            baseStats: [.init(name: "hp", value: 45)]
        )
        
        let mockFetchDetailUseCase = MockFetchPokemonDetailUseCase()
        mockFetchDetailUseCase.result = .success(pokemon)
        
        let store = TestStore(initialState: PokemonDetailViewFeature.State(pokemonId: 1)) {
            PokemonDetailViewFeature()
        } withDependencies: { dependencies in
            dependencies.fetchPokemonDetailUseCase = mockFetchDetailUseCase
        }
        
        await store.send(.onAppear) {
            $0.isLoading = true
        }
        
        await store.receive(.pokemonDetailResponse(TaskResult<PokemonDetail> { pokemon })) {
            $0.isLoading = false
            $0.pokemonDetail = PokemonDetailViewDTO(pokemon: pokemon)
        }
    }
    
    func test_onAppear_failure() async {
        let mockFetchDetailUseCase = MockFetchPokemonDetailUseCase()
        mockFetchDetailUseCase.result = .failure(TestError.someError)
        
        let store = TestStore(initialState: PokemonDetailViewFeature.State(pokemonId: 1)) {
            PokemonDetailViewFeature()
        } withDependencies: { dependencies in
            dependencies.fetchPokemonDetailUseCase = mockFetchDetailUseCase
        }
        
        await store.send(.onAppear) {
            $0.isLoading = true
        }
        
        await store.receive(.pokemonDetailResponse(TaskResult<PokemonDetail> { throw TestError.someError })) {
            $0.isLoading = false
            $0.error = TestError.someError.localizedDescription
        }
    }
    
    func test_playCry_success() async {
        let pokemon = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: "url",
            types: ["grass"],
            weight: 6.9,
            height: 0.7,
            baseStats: [.init(name: "hp", value: 45)]
        )
        
        let mockPlayCryUseCase = MockPlayPokemonCryUseCase()
        mockPlayCryUseCase.executeResult = .success(())
        
        var state = PokemonDetailViewFeature.State(pokemonId: 1)
        state.pokemonDetail = PokemonDetailViewDTO(pokemon: pokemon)
        
        let store = TestStore(initialState: state) {
            PokemonDetailViewFeature()
        } withDependencies: { dependencies in
            dependencies.playPokemonCryUseCase = mockPlayCryUseCase
        }
        
        await store.send(.playCry) {
            $0.isPlayingCry = true
        }
        
        await store.receive(.playCryResponse(TaskResult<Void> { })) {
            $0.isPlayingCry = false
        }
    }
    
    func test_playCry_failure() async {
        let pokemon = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: "url",
            types: ["grass"],
            weight: 6.9,
            height: 0.7,
            baseStats: [.init(name: "hp", value: 45)]
        )
        
        let mockPlayCryUseCase = MockPlayPokemonCryUseCase()
        mockPlayCryUseCase.executeResult = .failure(TestError.someError)
        
        var state = PokemonDetailViewFeature.State(pokemonId: 1)
        state.pokemonDetail = PokemonDetailViewDTO(pokemon: pokemon)
        
        let store = TestStore(initialState: state) {
            PokemonDetailViewFeature()
        } withDependencies: { dependencies in
            dependencies.playPokemonCryUseCase = mockPlayCryUseCase
        }
        
        await store.send(.playCry) {
            $0.isPlayingCry = true
        }
        
        await store.receive(.playCryResponse(TaskResult<Void> { throw TestError.someError })) {
            $0.isPlayingCry = false
            $0.error = TestError.someError.localizedDescription
        }
    }
}
