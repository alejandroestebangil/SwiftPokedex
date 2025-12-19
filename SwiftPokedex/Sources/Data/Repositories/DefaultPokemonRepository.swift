//
//  DefaultPokemonRepository.swift
//  SwiftPokedex
//
//  Created by Esteban, Alejandro1 on 2/12/24.
//

import CoreData
import Foundation
import Dependencies

final class DefaultPokemonRepository: PokemonRepository {
    @Dependency(\.networkService) private var networkService
    @Dependency(\.persistenceController) private var persistenceController
    
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
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let dto: PokemonDetailDTO = try await networkService.fetch(from: .pokemonDetail(id: id))
        return dto.toDomain()
    }
    
    private func savePokemonsToCoreData(_ pokemons: [Pokemon]) async throws {
        try await persistenceController.viewContext.perform {
            /// Clear existing data
            self.persistenceController.deleteAllPokemons()
            
            /// Save new data
            for pokemon in pokemons {
                let entity = PokemonEntity(context: self.persistenceController.viewContext)
                entity.update(from: pokemon)
            }
            
            try self.persistenceController.viewContext.save()
        }
    }
    
    private func fetchPokemonsFromCoreData() throws -> [Pokemon] {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let entities = try persistenceController.viewContext.fetch(request)
        return entities.map { $0.toDomain() }
    }
}
