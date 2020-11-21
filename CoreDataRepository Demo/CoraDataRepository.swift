//
//  CoraDataRepository.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//

import Foundation
import CoreData

class CoreDataRepository<RepositoryObject>: Repository
        where RepositoryObject: Entity,
              RepositoryObject.StoreType: NSManagedObject,
              RepositoryObject.StoreType.EntityObject == RepositoryObject {

    private var persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func fetch(predicate: NSPredicate?) throws -> [RepositoryObject] {
        let objects = try getManagedObjects(with: predicate)
        return objects.compactMap { $0.model }
    }

    func append(item: RepositoryObject) throws {
        persistentContainer.viewContext.insert(item.toStorable(in: persistentContainer.viewContext))
        saveContext()
    }
    
    func update(item: RepositoryObject) throws {
        try delete(item: item)
        try append(item: item)
    }
    
    func delete(item: RepositoryObject) throws {
        let predicate = NSPredicate(format: "id == %@", item.toStorable(in: persistentContainer.viewContext).id)
        let items = try getManagedObjects(with: predicate)

        persistentContainer.viewContext.delete(items.first!)
        saveContext()
    }
    
    private func getManagedObjects(with predicate: NSPredicate?) throws -> [RepositoryObject.StoreType] {
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<RepositoryObject.StoreType>(entityName: entityName)
        request.predicate = predicate
        
        return try persistentContainer.viewContext.fetch(request)
    }
    
    // MARK: - Core Data Saving support
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
