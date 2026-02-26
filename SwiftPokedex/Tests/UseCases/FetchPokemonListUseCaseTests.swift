import XCTest
import Dependencies
@testable import SwiftPokedex

final class FetchPokemonListUseCaseTests: XCTestCase {

    func test_execute_whenSuccess_shouldReturnPokemonList() async throws {
        // Given
        let pokemon = Pokemon.fixture()
        let repositoryStub = PokemonRepositoryStub()
        repositoryStub.fetchPokemonListToBeReturned = .success([pokemon])

        // When
        let result = try await withDependencies {
            $0.registerTestDependencies(repository: repositoryStub)
        } operation: {
            try await DefaultFetchPokemonListUseCase().execute()
        }

        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, pokemon.name)
    }

    func test_execute_whenFailure_shouldThrowError() async {
        // Given
        let repositoryStub = PokemonRepositoryStub()
        repositoryStub.fetchPokemonListToBeReturned = .failure(TestError.someError)

        // When / Then
        do {
            _ = try await withDependencies {
                $0.registerTestDependencies(repository: repositoryStub)
            } operation: {
                try await DefaultFetchPokemonListUseCase().execute()
            }
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
