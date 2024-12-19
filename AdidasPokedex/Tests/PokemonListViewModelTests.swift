//
//  PokemonListViewModelTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
@testable import AdidasPokedex

@MainActor
final class PokemonListViewModelTests: XCTestCase {
    var sut: PokemonListViewModel!
    var mockFetchListUseCase: MockFetchPokemonListUseCase!
    var mockFilterUseCase: MockFilterPokemonUseCase!
    
    override func setUp() async throws {
        try await super.setUp()
        mockFetchListUseCase = MockFetchPokemonListUseCase()
        mockFilterUseCase = MockFilterPokemonUseCase()
        sut = PokemonListViewModel(
            fetchPokemonListUseCase: mockFetchListUseCase,
            filterPokemonUseCase: mockFilterUseCase
        )
    }
    
    override func tearDown() async throws {
        sut = nil
        mockFetchListUseCase = nil
        mockFilterUseCase = nil
        try await super.tearDown()
    }
    
    func test_loadPokemonList_Success() async {
        // Given
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        mockFetchListUseCase.result = .success([pokemon])
        mockFilterUseCase.filterResult = [pokemon]
        
        // When
        await sut.loadPokemonList()
        
        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.filteredPokemons.first?.name, "Bulbasaur")
    }
    
    func test_updateGeneration() async {
        /// Given
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        mockFilterUseCase.filterResult = [pokemon]
        
        /// When
        sut.updateGeneration(.gen1)
        
        /// Then
        XCTAssertEqual(sut.selectedGeneration, .gen1)
    }
    
    func test_updateSortType() async {
        /// Given
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        mockFilterUseCase.filterResult = [pokemon]
        
        /// When
        sut.updateSortType(.name)
        
        /// Then
        XCTAssertEqual(sut.selectedSortType, .name)
    }
    
    func test_toggleSortOrder() async {
        /// When
        sut.toggleSortOrder()
        
        /// Then
        XCTAssertEqual(sut.selectedSortOrder, .descending)
    }
}
