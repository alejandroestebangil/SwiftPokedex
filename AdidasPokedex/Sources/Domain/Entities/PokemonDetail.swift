import Foundation

struct PokemonDetail: Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let types: [String]
    let weight: Double
    let height: Double
    let baseStats: [Stat]
    
    struct Stat {
        let name: String
        let value: Int
    }
}