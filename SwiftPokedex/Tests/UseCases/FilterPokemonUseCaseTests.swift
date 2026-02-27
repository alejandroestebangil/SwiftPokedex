import XCTest
@testable import SwiftPokedex

final class FilterPokemonUseCaseTests: XCTestCase {

    func test_execute_whenGen1_shouldReturnOnlyGen1Pokemon() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 1, name: "Bulbasaur")
        let pokemon2 = Pokemon.fixture(id: 152, name: "Chikorita")

        // When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .gen1,
            sortType: .id,
            sortOrder: .ascending
        )

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 1)
    }

    func test_execute_whenAllGenerations_shouldReturnAllPokemon() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 1, name: "Bulbasaur")
        let pokemon2 = Pokemon.fixture(id: 152, name: "Chikorita")

        // When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .id,
            sortOrder: .ascending
        )

        // Then
        XCTAssertEqual(result.count, 2)
    }

    func test_execute_whenSortByNameAscending_shouldReturnAlphabeticalOrder() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 1, name: "Bulbasaur")
        let pokemon2 = Pokemon.fixture(id: 2, name: "Abra")

        // When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .name,
            sortOrder: .ascending
        )

        // Then
        XCTAssertEqual(result.first?.name, "Abra")
    }

    func test_execute_whenSortByNameDescending_shouldReturnReverseAlphabeticalOrder() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 1, name: "Abra")
        let pokemon2 = Pokemon.fixture(id: 2, name: "Bulbasaur")

        // When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .name,
            sortOrder: .descending
        )

        // Then
        XCTAssertEqual(result.first?.name, "Bulbasaur")
    }

    func test_execute_whenSortByIdAscending_shouldReturnLowestFirst() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 25, name: "Pikachu")
        let pokemon2 = Pokemon.fixture(id: 1, name: "Bulbasaur")

        // When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .id,
            sortOrder: .ascending
        )

        // Then
        XCTAssertEqual(result.first?.id, 1)
    }

    func test_execute_whenSortByIdDescending_shouldReturnHighestFirst() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 1, name: "Bulbasaur")
        let pokemon2 = Pokemon.fixture(id: 25, name: "Pikachu")

        // When
        let result = sut.execute(
            pokemons: [pokemon1, pokemon2],
            generation: .all,
            sortType: .id,
            sortOrder: .descending
        )

        // Then
        XCTAssertEqual(result.first?.id, 25)
    }

    func test_execute_whenGenerationHasNoPokemon_shouldReturnEmpty() {
        // Given
        let sut = DefaultFilterPokemonUseCase()
        let pokemon1 = Pokemon.fixture(id: 1, name: "Bulbasaur")

        // When
        let result = sut.execute(
            pokemons: [pokemon1],
            generation: .gen2,
            sortType: .id,
            sortOrder: .ascending
        )

        // Then
        XCTAssertTrue(result.isEmpty)
    }
}
