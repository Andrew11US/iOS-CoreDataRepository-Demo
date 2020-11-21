//
//  CDWallet+CoreDataProperties.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//
//

import Foundation
import CoreData

extension CDWallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWallet> {
        return NSFetchRequest<CDWallet>(entityName: "CDWallet")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var amount: Double

}

extension CDWallet : Identifiable {

}
