import Foundation

struct PokemonListResponseDTO: Decodable {
    let count: Int
    let results: [PokemonListItemDTO]
}

struct PokemonListItemDTO: Decodable {
    let name: String
    let url: String
    
    var id: Int {
        /// Extract ID from the URL since PokeAPI includes it there
        guard let idString = url.split(separator: "/").last else { return 0 }
        return Int(idString) ?? 0
    }
    
    /// Convert DTO to domain model
    func toDomain() -> Pokemon {
        Pokemon(
            id: id,
            name: name,
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        )
    }
}

/// Extension to convert response to domain models
extension PokemonListResponseDTO {
    func toDomain() -> [Pokemon] {
        results.map { $0.toDomain() }
    }
}
