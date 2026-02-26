import XCTest
import Dependencies
@testable import SwiftPokedex

final class PlayPokemonCryUseCaseTests: XCTestCase {

    func testExecute_Success() async throws {
        /// Given
        let pokemonName = "Pikachu"
        let mockAudioService = MockPokemonAudioService()
        mockAudioService.playResult = .success(())

        /// When
        try await withDependencies {
            $0.audioService = mockAudioService
        } operation: {
            try await DefaultPlayPokemonCryUseCase().execute(pokemonName: pokemonName)
        }

        /// Then
        XCTAssertEqual(mockAudioService.playedPokemonName, pokemonName)
    }

    func testExecute_Failure() async {
        /// Given
        let pokemonName = "Pikachu"
        let mockAudioService = MockPokemonAudioService()
        mockAudioService.playResult = .failure(TestError.someError)

        /// When/Then
        do {
            try await withDependencies {
                $0.audioService = mockAudioService
            } operation: {
                try await DefaultPlayPokemonCryUseCase().execute(pokemonName: pokemonName)
            }
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
            XCTAssertEqual(mockAudioService.playedPokemonName, pokemonName)
        }
    }

    func testExecute_LowercasePokemonName() async throws {
        /// Given
        let pokemonName = "PIKACHU"
        let mockAudioService = MockPokemonAudioService()
        mockAudioService.playResult = .success(())

        /// When
        try await withDependencies {
            $0.audioService = mockAudioService
        } operation: {
            try await DefaultPlayPokemonCryUseCase().execute(pokemonName: pokemonName)
        }

        /// Then
        XCTAssertEqual(mockAudioService.playedPokemonName, pokemonName)
    }
}
