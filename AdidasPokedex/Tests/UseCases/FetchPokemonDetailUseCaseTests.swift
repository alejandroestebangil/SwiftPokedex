//
//  FetchPokemonDetailUseCaseTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
@testable import AdidasPokedex

final class FetchPokemonDetailUseCaseTests: XCTestCase {
    var sut: DefaultFetchPokemonDetailUseCase!
    var mockRepository: MockPokemonRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockPokemonRepository()
        sut = DefaultFetchPokemonDetailUseCase()
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        /// Given
        let detail = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: "url",
            types: ["grass"],
            weight: 6.9,
            height: 0.7,
            baseStats: [PokemonDetail.Stat(name: "hp", value: 45)]
        )
        mockRepository.pokemonDetailResult = .success(detail)
        
        /// When
        let result = try await sut.execute(id: 1)
        
        /// Then
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Bulbasaur")
        XCTAssertEqual(result.types, ["grass"])
    }
    
    func testExecute_Failure() async {
        /// Given
        mockRepository.pokemonDetailResult = .failure(TestError.someError)
        
        /// When/Then
        do {
            _ = try await sut.execute(id: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
