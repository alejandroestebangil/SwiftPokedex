//
//  PlayPokemonCryUseCaseTests.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import XCTest
@testable import SwiftPokedex

final class PlayPokemonCryUseCaseTests: XCTestCase {
    var sut: DefaultPlayPokemonCryUseCase!
    var mockAudioService: MockPokemonAudioService!
    
    override func setUp() {
        super.setUp()
        mockAudioService = MockPokemonAudioService()
        sut = DefaultPlayPokemonCryUseCase(audioService: mockAudioService)
    }
    
    override func tearDown() {
        sut = nil
        mockAudioService = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        /// Given
        let pokemonName = "Pikachu"
        mockAudioService.playResult = .success(())
        
        /// When
        try await sut.execute(pokemonName: pokemonName)
        
        /// Then
        XCTAssertEqual(mockAudioService.playedPokemonName, pokemonName)
    }
    
    func testExecute_Failure() async {
        /// Given
        let pokemonName = "Pikachu"
        mockAudioService.playResult = .failure(TestError.someError)
        
        /// When/Then
        do {
            try await sut.execute(pokemonName: pokemonName)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is TestError)
            XCTAssertEqual(mockAudioService.playedPokemonName, pokemonName)
        }
    }
    
    func testExecute_LowercasePokemonName() async throws {
        /// Given
        let pokemonName = "PIKACHU"
        mockAudioService.playResult = .success(())
        
        /// When
        try await sut.execute(pokemonName: pokemonName)
        
        /// Then
        XCTAssertEqual(mockAudioService.playedPokemonName, pokemonName)
    }
}
