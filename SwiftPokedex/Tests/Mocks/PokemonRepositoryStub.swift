import Foundation
@testable import SwiftPokedex

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

// Test Error
enum TestError: Error {
    case someError
}
