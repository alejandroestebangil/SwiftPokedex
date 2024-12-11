//
//  PokemonFilters.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 5/12/24.
//

import Foundation

enum PokemonGeneration: Int, CaseIterable {
    case all, gen1, gen2, gen3, gen4, gen5, gen6, gen7, gen8, gen9
    
    var range: ClosedRange<Int> {
        switch self {
        case .all: return 1...1025
        case .gen1: return 1...151
        case .gen2: return 152...251
        case .gen3: return 252...386
        case .gen4: return 387...493
        case .gen5: return 494...649
        case .gen6: return 650...721
        case .gen7: return 722...809
        case .gen8: return 810...905
        case .gen9: return 906...1025
        }
    }
    
    var displayName: String {
        if self == .all {
            return "All Gens"
        }
        return "Gen \(rawValue)"
    }
}

enum SortType {
    case name
    case id
    
    /*var displayName: String {
        switch self {
        case .name: return "Name" //posible moverlo a la  view e inlcuso las flechas
        case .id: return "Number" //no responsabilidad dominio
        }
    }*/
}

enum SortOrder {
    case ascending
    case descending
    
    /*var systemImage: String {
        switch self {
        case .ascending: return "arrow.up"
        case .descending: return "arrow.down"
        }
    }*/
}
