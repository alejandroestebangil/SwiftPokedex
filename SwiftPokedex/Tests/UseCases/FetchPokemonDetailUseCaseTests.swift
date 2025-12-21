import XCTest
import Dependencies
@testable import SwiftPokedex

final class FetchPokemonDetailUseCaseTests: XCTestCase {
    func testExecute_Success() async throws {
        /// Given
        let detail = PokemonDetail(
            id: 1,
            name: "Bulbasaur",
            imageUrl: "url",
            types: ["grass", "poison"],
            weight: 6.9,
            height: 0.7,
            baseStats: [.init(name: "hp", value: 45)]
        )
        let mockRepository = MockPokemonRepository()
        mockRepository.pokemonDetailResult = .success(detail)
        
        /// When
        let result = try await withDependencies {
            $0.registerTestDependencies(repository: mockRepository)
        } operation: {
            let useCase = DefaultFetchPokemonDetailUseCase()
            return try await useCase.execute(id: 1)
        }
        
        /// Then
        XCTAssertEqual(result.id, detail.id)
        XCTAssertEqual(result.name, detail.name)
        XCTAssertEqual(result.types, detail.types)
    }
    
  func testExecute_Failure() async {
        /// Given
        let mockRepository = MockPokemonRepository()
        mockRepository.pokemonDetailResult = .failure(TestError.someError)
        
        /// When/Then
        do {
            _ = try await withDependencies {
                $0.registerTestDependencies(repository: mockRepository)
            } operation: {
                let useCase = DefaultFetchPokemonDetailUseCase()
                return try await useCase.execute(id: 1)
            }
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
        }
    }
}
