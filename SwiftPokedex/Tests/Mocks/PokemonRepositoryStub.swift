import Foundation
@testable import SwiftPokedex

/// Test double — returns pre-configured results for list and detail calls.
final class PokemonRepositoryStub: PokemonRepository {
    var fetchPokemonListToBeReturned: Result<[Pokemon], Error> = .success([])
    var fetchPokemonDetailToBeReturned: Result<PokemonDetail, Error> = .success(.fixture())

    func fetchPokemonList() async throws -> [Pokemon] {
        try fetchPokemonListToBeReturned.get()
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        try fetchPokemonDetailToBeReturned.get()
    }
}

/// Shared test error used across all test files.
enum TestError: Error {
    case someError
}
