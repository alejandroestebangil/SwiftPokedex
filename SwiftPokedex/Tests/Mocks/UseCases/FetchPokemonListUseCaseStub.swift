import Foundation
@testable import SwiftPokedex

final class FetchPokemonListUseCaseStub: FetchPokemonListUseCase {
    var executeToBeReturned: Result<[Pokemon], Error> = .success([])

    func execute() async throws -> [Pokemon] {
        try executeToBeReturned.get()
    }
}
