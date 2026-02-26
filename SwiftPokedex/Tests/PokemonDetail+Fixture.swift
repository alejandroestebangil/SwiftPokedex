@testable import SwiftPokedex

extension PokemonDetail {
    static func fixture(
        id: Int = 1,
        name: String = "bulbasaur",
        imageUrl: String = "https://example.com/bulbasaur.png",
        types: [String] = ["grass", "poison"],
        weight: Double = 6.9,
        height: Double = 0.7,
        baseStats: [PokemonDetail.Stat] = [.init(name: "hp", value: 45)]
    ) -> PokemonDetail {
        PokemonDetail(
            id: id,
            name: name,
            imageUrl: imageUrl,
            types: types,
            weight: weight,
            height: height,
            baseStats: baseStats
        )
    }
}
