import Foundation

/// Maps the paginated `/pokemon?limit=N` response from PokeAPI.
struct PokemonListResponseDTO: Decodable {
    let count: Int
    let results: [PokemonListItemDTO]
}

struct PokemonListItemDTO: Decodable {
    let name: String
    let url: String
    
    /// PokeAPI doesn't include `id` directly — extract it from the resource URL.
    var id: Int {
        guard let idString = url.split(separator: "/").last else { return 0 }
        return Int(idString) ?? 0
    }
    
    /// Convert DTO to domain model
    func toDomain() -> Pokemon {
        Pokemon(
            id: id,
            name: name,
            imageUrl: SpriteURL.officialArtwork(for: id)
        )
    }
}

/// Extension to convert response to domain models
extension PokemonListResponseDTO {
    func toDomain() -> [Pokemon] {
        results.map { $0.toDomain() }
    }
}
