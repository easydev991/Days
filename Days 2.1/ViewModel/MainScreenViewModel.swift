//
//  ViewModel.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//
import UIKit
import RealmSwift

class MainScreenViewModel {
    
    let realm = try! Realm()
    var items: Results<ItemToRemember>?
    
    weak var mainView: MainViewController?

// MARK: - Convert Date() to string
    private let calendar = Calendar(identifier: .gregorian)
    
    func dateToTextDays(item: ItemToRemember) -> String {
        let today = Date().timeIntervalSince(item.date)
        return "\(Int(today)/86400) days"
    }
// MARK: - Methods for loading and saving items
    func loadItems() {
        items = realm.objects(ItemToRemember.self).sorted(byKeyPath: "date", ascending: true)
        mainView!.tableView.reloadData()
    }
    
    func saveItem(item: ItemToRemember) {
        try! realm.write {
            realm.add(item)
        }
        mainView!.tableView.reloadData()
    }
    
// MARK: - Pop-up alert

//    func addItem(){
//        var textField = UITextField()
//        let alert = UIAlertController(title: "Add new record", message: "", preferredStyle: .alert)
//        let action1 = UIAlertAction(title: "Save", style: .default) { action in
//            let newItem = ItemToRemember()
//            newItem.itemName = textField.text!
//            newItem.date = Date()
//            print("Saved date is \(newItem.date)")
//            self.saveItem(item: newItem)
//        }
//        alert.addAction(action1)
//        alert.addTextField { field in
//            textField = field
//            textField.placeholder = "Enter a new record"
//        }
//        mainView!.present(alert, animated: true)
//    }
}
