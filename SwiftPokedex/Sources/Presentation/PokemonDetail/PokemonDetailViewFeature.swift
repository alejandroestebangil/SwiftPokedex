import Foundation
import ComposableArchitecture
import Dependencies

/// TCA reducer for the Pokémon detail screen.
/// Handles fetching detail data, playing cries, and error dismissal.
public struct PokemonDetailViewFeature: Reducer {
    public struct State: Equatable {
        public let pokemonId: Int
        public var pokemonDetail: PokemonDetailViewDTO?
        public var isLoading = false
        public var isPlayingCry = false
        public var error: String?

        public init(pokemonId: Int) {
            self.pokemonId = pokemonId
        }
    }

    public enum Action: Equatable {
        case onAppear
        case pokemonDetailResponse(TaskResult<PokemonDetail>)
        case playCry
        case playCryResponse(TaskResult<Void>)
        case dismissError /// Clears the error alert so it can be dismissed by the user.

        /// Custom Equatable needed because `TaskResult` doesn't synthesize it.
        public static func == (lhs: Action, rhs: Action) -> Bool {
            switch (lhs, rhs) {
            case (.onAppear, .onAppear):
                return true
            case let (.pokemonDetailResponse(lhsResult), .pokemonDetailResponse(rhsResult)):
                switch (lhsResult, rhsResult) {
                case let (.success(lhsDetail), .success(rhsDetail)):
                    return lhsDetail.id == rhsDetail.id
                case let (.failure(lhsError), .failure(rhsError)):
                    return lhsError.localizedDescription == rhsError.localizedDescription
                default:
                    return false
                }
            case (.playCry, .playCry):
                return true
            case let (.playCryResponse(lhsResult), .playCryResponse(rhsResult)):
                switch (lhsResult, rhsResult) {
                case (.success, .success):
                    return true
                case let (.failure(lhsError), .failure(rhsError)):
                    return lhsError.localizedDescription == rhsError.localizedDescription
                default:
                    return false
                }
            case (.dismissError, .dismissError):
                return true
            default:
                return false
            }
        }
    }

    @Dependency(\.fetchPokemonDetailUseCase) var fetchPokemonDetailUseCase
    @Dependency(\.playPokemonCryUseCase) var playPokemonCryUseCase

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                /// Skip if already loading or data is present (prevents re-fetch on view reappear).
                guard !state.isLoading, state.pokemonDetail == nil else { return .none }
                state.isLoading = true
                return .run { [id = state.pokemonId] send in
                    await send(.pokemonDetailResponse(
                        TaskResult { try await fetchPokemonDetailUseCase.execute(id: id) }
                    ))
                }

            case let .pokemonDetailResponse(.success(detail)):
                state.isLoading = false
                state.pokemonDetail = PokemonDetailViewDTO(pokemon: detail)
                state.error = nil
                return .none

            case let .pokemonDetailResponse(.failure(error)):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none

            case .playCry:
                /// Ignore rapid taps while a cry is already playing.
                guard let pokemonName = state.pokemonDetail?.name, !state.isPlayingCry else { return .none }
                state.isPlayingCry = true
                return .run { send in
                    await send(.playCryResponse(
                        TaskResult { try await playPokemonCryUseCase.execute(pokemonName: pokemonName) }
                    ))
                }

            case .playCryResponse(.success):
                state.isPlayingCry = false
                return .none

            case .playCryResponse(.failure(let error)):
                state.isPlayingCry = false
                state.error = error.localizedDescription
                return .none

            case .dismissError:
                state.error = nil
                return .none
            }
        }
    }
}
