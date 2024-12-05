//
//  Pokemon.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

struct Pokemon: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "sprite_url"
    }
}
