public struct PokemonDetailViewDTO: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let imageUrl: String
    public let types: [String]
    public let height: Double
    public let weight: Double
    public let baseStats: [StatDTO]
    
    public struct StatDTO: Identifiable, Equatable {
        public let id: Int
        public let name: String
        public let value: Int
        
        init(id: Int, name: String, value: Int) {
            self.id = id // Using an id even though stats are unique
            self.name = name
            self.value = value
        }
    }
    
    init(pokemon: PokemonDetail) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
        self.types = pokemon.types
        self.height = pokemon.height
        self.weight = pokemon.weight
        self.baseStats = pokemon.baseStats.enumerated().map { index, stat in
            StatDTO(id: index, name: stat.name, value: stat.value)
        }
    }
}
