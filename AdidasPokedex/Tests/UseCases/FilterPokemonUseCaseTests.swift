//
//  FilterPokemonUseCaseTests.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
@testable import AdidasPokedex

final class FilterPokemonUseCaseTests: XCTestCase {
    var sut: DefaultFilterPokemonUseCase!
    
    override func setUp() {
        super.setUp()
        sut = DefaultFilterPokemonUseCase()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFilter_ByGeneration() {
        /// Given
        let pokemon1 = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        let pokemon2 = Pokemon(id: 152, name: "Chikorita", imageUrl: "url")
        
        /// When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .gen1,
            sortType: .id,
            sortOrder: .ascending
        )
        
        /// Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 1)
    }
    
    func testFilter_ByName() {
        /// Given
        let pokemon1 = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        let pokemon2 = Pokemon(id: 2, name: "Abra", imageUrl: "url")
        
        /// When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .name,
            sortOrder: .ascending
        )
        
        /// Then
        XCTAssertEqual(result.first?.name, "Abra")
    }
    
    func testFilter_ById() {
        /// Given
        let pokemon1 = Pokemon(id: 25, name: "Pikachu", imageUrl: "url")
        let pokemon2 = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        
        /// When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .id,
            sortOrder: .ascending
        )
        
        /// Then
        XCTAssertEqual(result.first?.id, 1)
    }
    
    func testFilter_DescendingOrder() {
        /// Given
        let pokemon1 = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        let pokemon2 = Pokemon(id: 25, name: "Pikachu", imageUrl: "url")
        
        /// When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .id,
            sortOrder: .descending
        )
        
        /// Then
        XCTAssertEqual(result.first?.id, 25)
    }
}
