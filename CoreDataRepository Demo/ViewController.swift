//
//  ViewController.swift
//  CoreDataRepository Demo
//
//  Created by Andrew on 11/21/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let dataManager = DataManager(with: CoreDataRepository<Wallet>(persistentContainer: container))
//        dataManager.addObject(wallet: Wallet(id: "abcd", name: "W2", amount: 123.45))
//        dataManager.updateObject(wallet: Wallet(id: "a", name: "AAA", amount: 777.11))
//        dataManager.removeObject(wallet: Wallet(id: "abcd", name: "W2", amount: 123.45))
        dataManager.getObjects(wallet: Wallet(id: "", name: "", amount: 0))
    }


}

class DataManager {

    private let repository: CoreDataRepository<Wallet>

    init(with repo: CoreDataRepository<Wallet>) {
        repository = repo
    }
    
    func addObject(wallet: Wallet) {
        try? repository.append(item: wallet)
    }
    
    func updateObject(wallet: Wallet) {
        try? repository.update(item: wallet)
    }
    
    func getObjects(wallet: Wallet) -> [Wallet] {
        let objects = try! repository.fetchAll()
        objects.forEach { print($0) }
        return objects
    }
    
    func removeObject(wallet: Wallet) {
        try? repository.delete(item: wallet)
    }
}
