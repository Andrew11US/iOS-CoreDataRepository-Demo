//
//  Wallet+Extensions.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//

import Foundation
import CoreData

extension Wallet: Entity {
    public func toStorable(in context: NSManagedObjectContext) -> CDWallet {
        let cdWallet = CDWallet.getManagedObject(with: id, from: context)
        cdWallet.id = id
        cdWallet.name = name
        cdWallet.amount = amount
        return cdWallet
    }
}

extension CDWallet: Storable {
    var model: Wallet {
        get { return Wallet(id: id, name: name, amount: amount) }
    }
}
