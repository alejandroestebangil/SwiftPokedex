import Foundation
import ComposableArchitecture

/// TCA reducer for the main Pokémon list screen.
/// Handles fetching, filtering/sorting, and navigation to detail.
struct PokemonListFeature: Reducer {

    @ObservableState
    struct State: Equatable {
        var pokemons: [Pokemon] = []
        var filteredPokemons: [PokemonListViewDTO] = []
        var isLoading = false
        var error: String?
        var selectedGeneration: PokemonGeneration = .all
        var selectedSortType: SortType = .id
        var selectedSortOrder: SortOrder = .ascending
        @Presents var destination: PokemonDetailViewFeature.State?
    }

    @CasePathable
    enum Action: Equatable {
        case onAppear
        case pokemonListResponse(TaskResult<[Pokemon]>)
        case updateGeneration(PokemonGeneration)
        case updateSortType(SortType)
        case toggleSortOrder
        case dismissError
        case pokemonTapped(id: Int)
        case destination(PresentationAction<PokemonDetailViewFeature.Action>)

        static func == (lhs: Action, rhs: Action) -> Bool {
            switch (lhs, rhs) {
            case (.onAppear, .onAppear):
                return true
            case let (.pokemonListResponse(lhsResult), .pokemonListResponse(rhsResult)):
                switch (lhsResult, rhsResult) {
                case let (.success(lhs), .success(rhs)):
                    return lhs == rhs
                case let (.failure(lhs), .failure(rhs)):
                    return lhs.localizedDescription == rhs.localizedDescription
                default:
                    return false
                }
            case let (.updateGeneration(lhs), .updateGeneration(rhs)):
                return lhs == rhs
            case let (.updateSortType(lhs), .updateSortType(rhs)):
                return lhs == rhs
            case (.toggleSortOrder, .toggleSortOrder):
                return true
            case (.dismissError, .dismissError):
                return true
            case let (.pokemonTapped(lhs), .pokemonTapped(rhs)):
                return lhs == rhs
            case let (.destination(lhs), .destination(rhs)):
                return lhs == rhs
            default:
                return false
            }
        }
    }

    @Dependency(\.fetchPokemonListUseCase) var fetchPokemonListUseCase
    @Dependency(\.filterPokemonUseCase) var filterPokemonUseCase

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard !state.isLoading else { return .none }
                state.isLoading = true
                state.error = nil
                return .run { send in
                    await send(.pokemonListResponse(
                        TaskResult { try await fetchPokemonListUseCase.execute() }
                    ))
                }

            case let .pokemonListResponse(.success(pokemons)):
                state.isLoading = false
                state.pokemons = pokemons
                state.filteredPokemons = filtered(pokemons: pokemons, state: state)
                return .none

            case let .pokemonListResponse(.failure(error)):
                state.isLoading = false
                state.error = error.localizedDescription
                return .none

            case let .updateGeneration(generation):
                state.selectedGeneration = generation
                state.filteredPokemons = filtered(pokemons: state.pokemons, state: state)
                return .none

            case let .updateSortType(sortType):
                state.selectedSortType = sortType
                state.filteredPokemons = filtered(pokemons: state.pokemons, state: state)
                return .none

            case .toggleSortOrder:
                state.selectedSortOrder = state.selectedSortOrder == .ascending ? .descending : .ascending
                state.filteredPokemons = filtered(pokemons: state.pokemons, state: state)
                return .none

            case .dismissError:
                state.error = nil
                return .none

            case let .pokemonTapped(id):
                state.destination = PokemonDetailViewFeature.State(pokemonId: id)
                return .none

            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            PokemonDetailViewFeature()
        }
    }

    /// Applies the current generation/sort filters and maps to view DTOs.
    private func filtered(pokemons: [Pokemon], state: State) -> [PokemonListViewDTO] {
        filterPokemonUseCase.execute(
            pokemons: pokemons,
            generation: state.selectedGeneration,
            sortType: state.selectedSortType,
            sortOrder: state.selectedSortOrder
        ).map { PokemonListViewDTO(pokemon: $0) }
    }
}
