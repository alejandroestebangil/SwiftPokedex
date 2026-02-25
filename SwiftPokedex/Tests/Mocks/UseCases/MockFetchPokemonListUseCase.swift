import Foundation
@testable import SwiftPokedex

class MockFetchPokemonListUseCase: FetchPokemonListUseCase {
    var result: Result<[Pokemon], Error> = .success([])
    
    func execute() async throws -> [Pokemon] {
        try result.get()
    }
}
