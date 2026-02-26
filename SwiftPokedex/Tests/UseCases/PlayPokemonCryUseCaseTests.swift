import XCTest
import Dependencies
@testable import SwiftPokedex

final class PlayPokemonCryUseCaseTests: XCTestCase {

    func test_execute_whenSuccess_shouldPlayCry() async throws {
        // Given
        let pokemonName = "Pikachu"
        let audioServiceMock = PokemonAudioServiceMock()
        audioServiceMock.playPokemonCryToBeReturned = .success(())

        // When
        try await withDependencies {
            $0.audioService = audioServiceMock
        } operation: {
            try await DefaultPlayPokemonCryUseCase().execute(pokemonName: pokemonName)
        }

        // Then
        XCTAssertEqual(audioServiceMock.playPokemonCryNamePassed, pokemonName)
    }

    func test_execute_whenFailure_shouldThrowError() async {
        // Given
        let pokemonName = "Pikachu"
        let audioServiceMock = PokemonAudioServiceMock()
        audioServiceMock.playPokemonCryToBeReturned = .failure(TestError.someError)

        // When / Then
        do {
            try await withDependencies {
                $0.audioService = audioServiceMock
            } operation: {
                try await DefaultPlayPokemonCryUseCase().execute(pokemonName: pokemonName)
            }
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
            XCTAssertEqual(audioServiceMock.playPokemonCryNamePassed, pokemonName)
        }
    }

    func test_execute_shouldPassPokemonNameToAudioService() async throws {
        // Given
        let pokemonName = "PIKACHU"
        let audioServiceMock = PokemonAudioServiceMock()
        audioServiceMock.playPokemonCryToBeReturned = .success(())

        // When
        try await withDependencies {
            $0.audioService = audioServiceMock
        } operation: {
            try await DefaultPlayPokemonCryUseCase().execute(pokemonName: pokemonName)
        }

        // Then
        XCTAssertEqual(audioServiceMock.playPokemonCryNamePassed, pokemonName)
    }
}
