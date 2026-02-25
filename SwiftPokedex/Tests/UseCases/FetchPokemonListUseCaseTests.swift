import XCTest
import Dependencies
@testable import SwiftPokedex

final class FetchPokemonListUseCaseTests: XCTestCase {
    func testExecute_Success() async throws {
        /// Given
        let pokemon = Pokemon(id: 1, name: "Bulbasaur", imageUrl: "url")
        let mockRepository = MockPokemonRepository()
        mockRepository.pokemonListResult = .success([pokemon])
        
        /// When
        let result = try await withDependencies {
            $0.registerTestDependencies(repository: mockRepository)
        } operation: {
            let useCase = DefaultFetchPokemonListUseCase()
            return try await useCase.execute()
        }
        
        /// Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Bulbasaur")
    }
    
    func testExecute_Failure() async {
        // Given
        let mockRepository = MockPokemonRepository()
        mockRepository.pokemonListResult = .failure(TestError.someError)
        
        // When/Then
        do {
            _ = try await withDependencies {
                $0.registerTestDependencies(repository: mockRepository)
            } operation: {
                let useCase = DefaultFetchPokemonListUseCase()
                return try await useCase.execute()
            }
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
