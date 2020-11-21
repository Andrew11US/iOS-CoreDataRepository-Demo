//
//  Wallet.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//

struct Wallet {
    var id: String
    var name: String
    var amount: Double

    internal init(id: String, name: String, amount: Double) {
        self.id = id
        self.name = name
        self.amount = amount
    }
}
