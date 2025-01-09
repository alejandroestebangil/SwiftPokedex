//
//  FetchPokemonListUseCaseTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
@testable import AdidasPokedex

final class FetchPokemonListUseCaseTests: XCTestCase {
    var sut: DefaultFetchPokemonListUseCase!
    var mockRepository: MockPokemonRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockPokemonRepository()
        sut = DefaultFetchPokemonListUseCase()
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        /// Given
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        mockRepository.pokemonListResult = .success([pokemon])
        
        /// When
        let result = try await sut.execute()
        
        /// Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Bulbasaur")
    }
    
    func testExecute_Failure() async {
        /// Given
        mockRepository.pokemonListResult = .failure(TestError.someError)
        
        /// When/Then
        do {
            _ = try await sut.execute()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
