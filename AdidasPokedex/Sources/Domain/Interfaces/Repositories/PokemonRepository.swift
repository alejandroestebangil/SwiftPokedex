//
//  PokemonRepository.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//


import Foundation

protocol PokemonRepository {
    func fetchPokemonList() async throws -> [Pokemon]
    func fetchPokemon(id: Int) async throws -> Pokemon
}
