@testable import SwiftPokedex

/// Convenience factory for tests — all fields have sensible defaults.
extension Pokemon {
    static func fixture(
        id: Int = 1,
        name: String = "bulbasaur",
        imageUrl: String = "https://example.com/bulbasaur.png"
    ) -> Pokemon {
        Pokemon(id: id, name: name, imageUrl: imageUrl)
    }
}
