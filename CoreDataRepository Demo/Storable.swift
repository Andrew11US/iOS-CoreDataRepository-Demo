//
//  Storable.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//

import Foundation
import CoreData

extension Storable where Self: NSManagedObject {
    static func getManagedObject(with id: String, from context: NSManagedObjectContext) -> Self {
        let result = getObject(with: id, from: context) ?? insertObject(in: context)
        result.setValue(id, forKey: "id")
        return result
    }
    
    static func getObject(with id: String, from context: NSManagedObjectContext) -> Self? {
        return fetchObjects(with: id, from: context)?.first
    }
    
    static func insertObject(in context: NSManagedObjectContext) -> Self {
        return Self(context: context)
    }
    
    static func fetchObjects(with id: String, from context: NSManagedObjectContext) -> [Self]? {
        let entityName = String(describing: Self.self)
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.fetchLimit = 1
        
        let result: [Self]? = try? context.fetch(fetchRequest)
        
        return result
    }
}
