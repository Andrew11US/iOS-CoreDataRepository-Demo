//
//  Repository.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//

import Foundation
import CoreData

protocol Repository {
    associatedtype EntityObject: Entity
    
    func fetch(predicate: NSPredicate?) throws -> [EntityObject]
    func append(item: EntityObject) throws
    func update(item: EntityObject) throws
    func delete(item: EntityObject) throws
}

extension Repository {
    func fetchAll() throws -> [EntityObject] {
        return try fetch(predicate: nil)
    }
}

protocol Entity {
    associatedtype StoreType: Storable
    
    func toStorable(in context: NSManagedObjectContext) -> StoreType
}

protocol Storable {
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    var id: String { get }
}
