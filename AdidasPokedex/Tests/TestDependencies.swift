//
//  TestDependencies.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 7/1/25.
//

import Dependencies
import XCTest
@testable import AdidasPokedex

// Repository dependency
private enum PokemonRepositoryKey: DependencyKey {
    static let liveValue: PokemonRepository = {
        DefaultPokemonRepository()
    }()
    static var testValue: PokemonRepository = MockPokemonRepository()
}

private enum NetworkServiceClient: DependencyKey {
    static let liveValue: NetworkService = DefaultNetworkService()
}

private enum PersistenceClient: DependencyKey {
    static let liveValue = PersistenceController.shared
}

// Service dependencies
private enum AudioServiceKey: DependencyKey {
    static let liveValue: PokemonAudioServiceProtocol = PokemonAudioService()
    static var testValue: PokemonAudioServiceProtocol = MockPokemonAudioService()
}

// Use case test dependencies
private enum FetchPokemonListUseCaseKey: DependencyKey {
    static let liveValue: FetchPokemonListUseCase = DefaultFetchPokemonListUseCase()
    static var testValue: FetchPokemonListUseCase = MockFetchPokemonListUseCase()
}

private enum FetchPokemonDetailUseCaseKey: DependencyKey {
    static let liveValue: FetchPokemonDetailUseCase = DefaultFetchPokemonDetailUseCase()
    static var testValue: FetchPokemonDetailUseCase = MockFetchPokemonDetailUseCase()
}

private enum FilterPokemonUseCaseKey: DependencyKey {
    static let liveValue: FilterPokemonUseCase = DefaultFilterPokemonUseCase()
    static var testValue: FilterPokemonUseCase = MockFilterPokemonUseCase()
}

private enum PlayPokemonCryUseCaseKey: DependencyKey {
    static let liveValue: PlayPokemonCryUseCase = {
        DefaultPlayPokemonCryUseCase(audioService: AudioServiceKey.liveValue)
    }()
    static var testValue: PlayPokemonCryUseCase = MockPlayPokemonCryUseCase()
}

extension DependencyValues {
    var networkService: NetworkService {
        get { self[NetworkServiceClient.self] }
        set { self[NetworkServiceClient.self] = newValue }
    }
    
    var persistence: PersistenceController {
        get { self[PersistenceClient.self] }
        set { self[PersistenceClient.self] = newValue }
    }
    
    var pokemonRepository: PokemonRepository {
        get { self[PokemonRepositoryKey.self] }
        set { self[PokemonRepositoryKey.self] = newValue }
    }
    
    var audioService: PokemonAudioServiceProtocol {
        get { self[AudioServiceKey.self] }
        set { self[AudioServiceKey.self] = newValue }
    }
    
    var fetchPokemonListUseCase: FetchPokemonListUseCase {
        get { self[FetchPokemonListUseCaseKey.self] }
        set { self[FetchPokemonListUseCaseKey.self] = newValue }
    }
    
    var fetchPokemonDetailUseCase: FetchPokemonDetailUseCase {
        get { self[FetchPokemonDetailUseCaseKey.self] }
        set { self[FetchPokemonDetailUseCaseKey.self] = newValue }
    }
    
    var filterPokemonUseCase: FilterPokemonUseCase {
        get { self[FilterPokemonUseCaseKey.self] }
        set { self[FilterPokemonUseCaseKey.self] = newValue }
    }
    
    var playPokemonCryUseCase: PlayPokemonCryUseCase {
        get { self[PlayPokemonCryUseCaseKey.self] }
        set { self[PlayPokemonCryUseCaseKey.self] = newValue }
    }
}
