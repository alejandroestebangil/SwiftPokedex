import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init() {
        container = NSPersistentContainer(name: "PokemonModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
    }

    /// Deletes all PokemonEntity objects from the context.
    /// Uses `context.delete()` instead of `NSBatchDeleteRequest` so the
    /// in-memory object graph stays consistent — no stale objects after delete.
    /// Must be called from within a `viewContext.perform {}` block.
    func deleteAllPokemons() throws {
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        let entities = try viewContext.fetch(request)
        for entity in entities {
            viewContext.delete(entity)
        }
    }
}
