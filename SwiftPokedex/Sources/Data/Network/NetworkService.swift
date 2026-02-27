import Foundation

/// Generic network layer — fetches JSON from an `APIEndpoint` and decodes it.
protocol NetworkService {
    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T
}

final class DefaultNetworkService: NetworkService {
    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        /// Validation HTTP Response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        /// Decode the JSON into the specified type
        return try JSONDecoder().decode(T.self, from: data)
    }
}
