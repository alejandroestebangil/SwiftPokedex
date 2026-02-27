import CoreData

/// Bridges between CoreData `PokemonEntity` and the domain `Pokemon` model.
extension PokemonEntity {
    /// Maps CoreData attributes to a domain `Pokemon`.
    /// Optional strings default to empty — CoreData marks them as optional.
    func toDomain() -> Pokemon {
        Pokemon(
            id: Int(id),
            name: name ?? "",
            imageUrl: imageUrl ?? ""
        )
    }

    /// Writes domain values into the managed object for persistence.
    func update(from pokemon: Pokemon) {
        self.id = Int64(pokemon.id)
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
    }
}
