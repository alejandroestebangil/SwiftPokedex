//
//  PokemonDetailViewModelTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
@testable import AdidasPokedex

@MainActor
final class PokemonDetailViewModelTests: XCTestCase {
    var sut: PokemonDetailViewModel!
    var mockFetchDetailUseCase: MockFetchPokemonDetailUseCase!
    var mockPlayCryUseCase: MockPlayPokemonCryUseCase!
    
    override func setUp() async throws {
        try await super.setUp()
        mockFetchDetailUseCase = MockFetchPokemonDetailUseCase()
        mockPlayCryUseCase = MockPlayPokemonCryUseCase()
        sut = PokemonDetailViewModel(
            pokemonId: 1,
            fetchPokemonDetailUseCase: mockFetchDetailUseCase,
            playPokemonCryUseCase: mockPlayCryUseCase
        )
    }
    
    override func tearDown() async throws {
        sut = nil
        mockFetchDetailUseCase = nil
        mockPlayCryUseCase = nil
        try await super.tearDown()
    }
    
    func test_loadPokemonDetail_Success() async {
        /// Given
        let detail = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: "url",
            types: ["grass"],
            weight: 6.9,
            height: 0.7,
            baseStats: [.init(name: "hp", value: 45)]
        )
        mockFetchDetailUseCase.result = .success(detail)
        
        /// When
        await sut.loadPokemonDetail()
        
        /// Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.pokemonDetail?.name, "Bulbasaur")
    }
    
    func test_loadPokemonDetail_Failure() async {
        /// Given
        mockFetchDetailUseCase.result = .failure(TestError.someError)
        
        /// When
        await sut.loadPokemonDetail()
        
        /// Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.error)
        XCTAssertNil(sut.pokemonDetail)
    }
}
