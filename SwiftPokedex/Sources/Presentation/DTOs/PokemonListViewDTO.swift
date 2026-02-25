struct PokemonListViewDTO: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageUrl: String
    
    init(pokemon: Pokemon) {
        self.id = pokemon.id
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
    }
}
