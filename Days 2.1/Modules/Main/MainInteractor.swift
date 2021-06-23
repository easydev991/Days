//
//  MainInteractor.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func loadItems()
    func saveItem(item: Item)
    func removeItem(item: Item)
    func addItem(with title: String)
    func dateToTextDays(item: Item) -> String
}

final class MainInteractor: MainInteractorProtocol {
    
    // MARK: - Public properties
    
    weak var presenter: MainPresenterProtocol!
    
    // MARK: - Init
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Methods
    
    func loadItems() {
        presenter.items = presenter.realm.objects(Item.self).sorted(byKeyPath: "date", ascending: false)
        presenter.reloadTVData()
    }
    
    func saveItem(item: Item) {
        try! presenter.realm.write {
            presenter.realm.add(item)
        }
        presenter.reloadTVData()
    }
    
    func addItem(with title: String) {
        let newItem = Item()
        newItem.itemName = title
        saveItem(item: newItem)
    }
    
    func removeItem(item: Item) {
        do {
            try presenter.realm.write {
                presenter.realm.delete(item)
            }
        } catch {
            print("Error deleting item, \(error)")
        }
    }
    
    func dateToTextDays(item: Item) -> String {
        let today = Date().timeIntervalSince(item.date)
        let daysCount = Int(today)/86400
        return daysCount > 0 ? "\(daysCount) days ago" : "\(-daysCount) days left"
    }
    
}
