/// View-layer model for the Pokémon list. Maps 1:1 from the domain `Pokemon`.
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
