import Foundation
@testable import SwiftPokedex

class MockNetworkService: NetworkService {
    var result: Result<Data, Error> = .success(Data())
    
    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        let data = try result.get()
        return try JSONDecoder().decode(T.self, from: data)
    }
}
