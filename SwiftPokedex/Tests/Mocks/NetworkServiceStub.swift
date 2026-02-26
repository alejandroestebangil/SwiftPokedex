import Foundation
@testable import SwiftPokedex

final class NetworkServiceStub: NetworkService {
    var fetchToBeReturned: Result<Data, Error> = .success(Data())

    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        let data = try fetchToBeReturned.get()
        return try JSONDecoder().decode(T.self, from: data)
    }
}
