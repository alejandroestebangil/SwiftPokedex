//
//  DefaultPokemonRepository.swift
//  AdidasPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import CoreData
import Foundation

final class DefaultPokemonRepository: PokemonRepository {
    private let networkService: NetworkService
    private let persistence: PersistenceController
    
    init(networkService: NetworkService, persistence: PersistenceController) {
        self.networkService = networkService
        self.persistence = persistence
    }
    
    func fetchPokemonList() async throws -> [Pokemon] {
        do {
            /// Try to fetch from API
            let response: PokemonListResponseDTO = try await networkService.fetch(from: .pokemonList())
            let pokemons = response.toDomain()
            
            /// Save to CoreData
            try await savePokemonsToCoreData(pokemons)
            return pokemons
        } catch {
            /// If API fails, try to fetch from CoreData
            return try fetchPokemonsFromCoreData()
        }
    }
    
    private func savePokemonsToCoreData(_ pokemons: [Pokemon]) async throws {
        try await persistence.viewContext.perform {
            /// Clear existing data
            self.persistence.deleteAllPokemons()
            
            /// Save new data
            for pokemon in pokemons {
                let entity = PokemonEntity(context: self.persistence.viewContext)
                entity.update(from: pokemon)
            }
            
            try self.persistence.viewContext.save()
        }
    }
    
    private func fetchPokemonsFromCoreData() throws -> [Pokemon] {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let entities = try persistence.viewContext.fetch(request)
        return entities.map { $0.toDomain() }
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let dto: PokemonDetailDTO = try await networkService.fetch(from: .pokemonDetail(id: id))
        return dto.toDomain()
    }
}
