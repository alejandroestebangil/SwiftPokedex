//
//  StatsEnhancer.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro on 19/12/24.
//

import SwiftUI

/// Adds color depending on Pokémon type.
func typeColor(for type: String) -> Color {
    switch type.lowercased() {
    case "normal": return Color(.systemGray)
    case "fighting": return Color(.systemRed)
    case "flying": return Color(.systemBlue)
    case "poison": return .purple
    case "ground": return .brown
    case "rock": return .brown
    case "bug": return .green
    case "ghost": return .purple
    case "steel": return Color(.systemGray)
    case "fire": return .red
    case "water": return .blue
    case "grass": return .green
    case "electric": return .yellow
    case "psychic": return .pink
    case "ice": return Color(.systemTeal)
    case "dragon": return .purple
    case "dark": return Color(.darkGray)
    case "fairy": return .pink
    default: return Color(.systemGray)
    }
}

/// Adds color based on the stat value.
func statColor(value: Int) -> Color {
    if value < 60 {
        return .red
    } else if value < 90 {
        return .orange
    } else if value < 120 {
        return .green
    } else {
        return .indigo
    }
}

/// Converts stat keys into better names.
func statName(_ name: String) -> String {
    switch name {
    case "hp": return "HP"
    case "attack": return "Attack"
    case "defense": return "Defense"
    case "special-attack": return "Special Attack"
    case "special-defense": return "Special Defense"
    case "speed": return "Speed"
    default: return name.capitalized
    }
}
