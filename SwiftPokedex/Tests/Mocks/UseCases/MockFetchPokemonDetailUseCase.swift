import Foundation
@testable import SwiftPokedex

class MockFetchPokemonDetailUseCase: FetchPokemonDetailUseCase {
    var result: Result<PokemonDetail, Error> = .success(PokemonDetail(id: 0, name: "", imageUrl: "", types: [], weight: 0, height: 0,  baseStats: []))
    
    func execute(id: Int) async throws -> PokemonDetail {
        try result.get()
    }
}
