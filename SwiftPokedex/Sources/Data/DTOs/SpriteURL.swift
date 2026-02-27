/// Centralised sprite URL builder — avoids duplicating the GitHub raw URL across DTOs.
enum SpriteURL {
    static func officialArtwork(for id: Int) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
}
