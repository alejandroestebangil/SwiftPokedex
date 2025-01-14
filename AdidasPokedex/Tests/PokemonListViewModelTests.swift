//
//  PokemonListViewModelTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
import Dependencies
@testable import AdidasPokedex

@MainActor
final class PokemonListViewModelTests: XCTestCase {
    func test_loadPokemonList_Success() async {
        let mockFetchListUseCase = MockFetchPokemonListUseCase()
        let mockFilterUseCase = MockFilterPokemonUseCase()
        mockFetchListUseCase.result = .success([
            Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        ])
        
        let viewModel = await withDependencies {
            $0.registerTestDependencies(
                fetchListUseCase: mockFetchListUseCase,
                filterPokemonUseCase: mockFilterUseCase
            )
        } operation: {
            PokemonListViewModel()
        }
        
        await viewModel.loadPokemonList()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    func test_updateGeneration() async {
        let mockFilterUseCase = MockFilterPokemonUseCase()
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        mockFilterUseCase.filterResult = [pokemon]
        
        let result = await withDependencies {
            $0.filterPokemonUseCase = mockFilterUseCase
        } operation: {
            let viewModel = PokemonListViewModel()
            viewModel.updateGeneration(.gen1)
            return viewModel
        }
        
        XCTAssertEqual(result.selectedGeneration, .gen1)
    }
}


