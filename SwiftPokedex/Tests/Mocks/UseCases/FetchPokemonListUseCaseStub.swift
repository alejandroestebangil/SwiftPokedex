import Foundation
@testable import SwiftPokedex

/// Test double — returns a configurable list result without hitting the network.
final class FetchPokemonListUseCaseStub: FetchPokemonListUseCase {
    var executeToBeReturned: Result<[Pokemon], Error> = .success([])

    func execute() async throws -> [Pokemon] {
        try executeToBeReturned.get()
    }
}
