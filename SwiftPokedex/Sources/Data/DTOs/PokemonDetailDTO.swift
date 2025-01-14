//
//  PokemonDetailDTO.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro on 10/12/24.
//

struct PokemonDetailDTO: Decodable {
    let id: Int
    let name: String
    let types: [TypeData]
    let weight: Int
    let height: Int
    let stats: [StatData]
    
    struct TypeData: Decodable {
        let slot: Int
        let type: TypeInfo
        
        struct TypeInfo: Decodable {
            let name: String
        }
    }
    
    struct StatData: Decodable {
        let baseStat: Int
        let stat: StatInfo
        
        struct StatInfo: Decodable {
            let name: String
        }
        
        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
    }
    
    /// Convert DTO to domain model
    func toDomain() -> PokemonDetail {
        PokemonDetail(
            id: id,
            name: name,
            imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png",
            types: types.map { $0.type.name },
            weight: Double(weight) / 10.0, // In kg
            height: Double(height) / 10.0, // In m
            baseStats: stats.map {
                PokemonDetail.Stat(name: $0.stat.name, value: $0.baseStat)
            }
        )
    }
}
