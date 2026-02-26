import Dependencies
import Foundation

// MARK: - Services
struct NetworkServiceClient: DependencyKey {
    static let liveValue: NetworkService = DefaultNetworkService()
}

struct PersistenceClient: DependencyKey {
    static let liveValue = PersistenceController.shared
}

struct AudioServiceClient: DependencyKey {
    static let liveValue: PokemonAudioServiceProtocol = PokemonAudioService()
}

// MARK: - Repository
struct PokemonRepositoryClient: DependencyKey {
    static let liveValue: PokemonRepository = DefaultPokemonRepository()
}

// MARK: - Use Cases
struct FetchPokemonDetailUseCaseClient: DependencyKey {
    static let liveValue: FetchPokemonDetailUseCase = DefaultFetchPokemonDetailUseCase()
}

struct FilterPokemonUseCaseClient: DependencyKey {
    static let liveValue: FilterPokemonUseCase = DefaultFilterPokemonUseCase()
}

struct FetchPokemonListUseCaseClient: DependencyKey {
    static let liveValue: FetchPokemonListUseCase = DefaultFetchPokemonListUseCase()
}

struct PlayPokemonCryUseCaseClient: DependencyKey {
    static let liveValue: PlayPokemonCryUseCase = DefaultPlayPokemonCryUseCase()
}

// MARK: - Dependencies Registration
extension DependencyValues {
    var networkService: NetworkService {
        get { self[NetworkServiceClient.self] }
        set { self[NetworkServiceClient.self] = newValue }
    }
    
    var persistenceController: PersistenceController {
        get { self[PersistenceClient.self] }
        set { self[PersistenceClient.self] = newValue }
    }
    
    var audioService: PokemonAudioServiceProtocol {
        get { self[AudioServiceClient.self] }
        set { self[AudioServiceClient.self] = newValue }
    }
    
    var pokemonRepository: PokemonRepository {
        get { self[PokemonRepositoryClient.self] }
        set { self[PokemonRepositoryClient.self] = newValue }
    }
    
    var fetchPokemonListUseCase: FetchPokemonListUseCase {
        get { self[FetchPokemonListUseCaseClient.self] }
        set { self[FetchPokemonListUseCaseClient.self] = newValue }
    }
    
    var filterPokemonUseCase: FilterPokemonUseCase {
        get { self[FilterPokemonUseCaseClient.self] }
        set { self[FilterPokemonUseCaseClient.self] = newValue }
    }
    
    var fetchPokemonDetailUseCase: FetchPokemonDetailUseCase {
        get { self[FetchPokemonDetailUseCaseClient.self] }
        set { self[FetchPokemonDetailUseCaseClient.self] = newValue }
    }
    
    var playPokemonCryUseCase: PlayPokemonCryUseCase {
        get { self[PlayPokemonCryUseCaseClient.self] }
        set { self[PlayPokemonCryUseCaseClient.self] = newValue }
    }
}
