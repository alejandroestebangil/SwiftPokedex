//
//  PokemonDetailViewFeature.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 9/1/25.
//

import ComposableArchitecture
import Dependencies

@Reducer
struct PokemonDetailViewFeature {
    struct State: Equatable {
        let pokemonId: Int
        var pokemonDetail: PokemonDetailViewDTO?
        var isLoading = false
        var isPlayingCry = false
        var error: String?
    }
    
    enum Action {
        case onAppear
        case pokemonDetailResponse(TaskResult<PokemonDetail>)
        case playCry
        case playCryResponse(TaskResult<Void>)
    }
    
    @Dependency(\.fetchPokemonDetailUseCase) var fetchPokemonDetailUseCase
    @Dependency(\.playPokemonCryUseCase) var playPokemonCryUseCase
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
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
                guard let pokemonName = state.pokemonDetail?.name else { return .none }
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
            }
        }
    }
}
