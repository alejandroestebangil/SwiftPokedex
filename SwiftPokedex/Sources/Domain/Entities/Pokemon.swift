import Foundation

/// Domain entity — no Codable conformance since it's never serialized directly.
/// Data-layer DTOs handle encoding/decoding; CoreData uses PokemonEntity+Mapping.
struct Pokemon: Identifiable, Equatable, Sendable {
    let id: Int
    let name: String
    let imageUrl: String
}
