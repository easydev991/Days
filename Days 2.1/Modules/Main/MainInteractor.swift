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
}

final class MainInteractor {
    weak var presenter: MainPresenterProtocol?
}

extension MainInteractor: MainInteractorProtocol {
    func loadItems() {
        presenter?.items = presenter?.realm.objects(Item.self).sorted(byKeyPath: "date", ascending: false)
        presenter?.reloadTVData()
    }

    func saveItem(item: Item) {
        try! presenter?.realm.write {
            presenter?.realm.add(item)
        }
        presenter?.reloadTVData()
    }

    func removeItem(item: Item) {
        do {
            try presenter?.realm.write {
                presenter?.realm.delete(item)
            }
        } catch {
            print("Error deleting item: \(error)")
        }
    }
}
