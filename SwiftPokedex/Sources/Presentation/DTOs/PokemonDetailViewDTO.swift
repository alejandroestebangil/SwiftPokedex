/// View-layer model for the detail screen. Converts domain `PokemonDetail` for display.
public struct PokemonDetailViewDTO: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let imageUrl: String
    public let types: [String]
    public let height: Double
    public let weight: Double
    public let baseStats: [StatDTO]
    
    public struct StatDTO: Identifiable, Equatable {
        public var id: String { name }
        public let name: String
        public let value: Int
    }

    init(pokemon: PokemonDetail) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
        self.types = pokemon.types
        self.height = pokemon.height
        self.weight = pokemon.weight
        self.baseStats = pokemon.baseStats.map { StatDTO(name: $0.name, value: $0.value) }
    }
}
