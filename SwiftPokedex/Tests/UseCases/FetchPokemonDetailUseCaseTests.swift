import XCTest
import Dependencies
@testable import SwiftPokedex

final class FetchPokemonDetailUseCaseTests: XCTestCase {

    func test_execute_whenSuccess_shouldReturnPokemonDetail() async throws {
        // Given
        let pokemon = PokemonDetail.fixture()
        let repositoryStub = PokemonRepositoryStub()
        repositoryStub.fetchPokemonDetailToBeReturned = .success(pokemon)

        // When
        let result = try await withDependencies {
            $0.registerTestDependencies(repository: repositoryStub)
        } operation: {
            try await DefaultFetchPokemonDetailUseCase().execute(id: 1)
        }

        // Then
        XCTAssertEqual(result.id, pokemon.id)
        XCTAssertEqual(result.name, pokemon.name)
        XCTAssertEqual(result.types, pokemon.types)
    }

    func test_execute_whenFailure_shouldThrowError() async {
        // Given
        let repositoryStub = PokemonRepositoryStub()
        repositoryStub.fetchPokemonDetailToBeReturned = .failure(TestError.someError)

        // When / Then
        do {
            _ = try await withDependencies {
                $0.registerTestDependencies(repository: repositoryStub)
            } operation: {
                try await DefaultFetchPokemonDetailUseCase().execute(id: 1)
            }
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
