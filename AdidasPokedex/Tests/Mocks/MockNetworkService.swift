//
//  MockNetworkService.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 8/1/25.
//

import Foundation
@testable import AdidasPokedex

class MockNetworkService: NetworkService {
    var result: Result<Data, Error> = .success(Data())
    
    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        let data = try result.get()
        return try JSONDecoder().decode(T.self, from: data)
    }
}
