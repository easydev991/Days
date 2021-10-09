//
//  ItemStorage.swift
//  Days 2.1
//
//  Created by Олег Еременко on 09.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import Foundation
import RealmSwift

protocol ItemStorageService {
    func loadItems(
        sortedBy: ItemsSort,
        ascending: Bool
    ) -> [Item]

    func saveItem(
        item: Item,
        completion: ErrorVoidBlock
    )

    func remove(
        item: Item,
        completion: ErrorVoidBlock
    )
}

enum ItemsSort: String {
    case itemName, date
}

final class ItemStorage {
    private let realm = try! Realm()
}

extension ItemStorage: ItemStorageService {
    func loadItems(
        sortedBy: ItemsSort,
        ascending: Bool
    ) -> [Item] {
        realm.objects(Item.self)
            .sorted(
                byKeyPath: sortedBy.rawValue,
                ascending: ascending
            )
            .toArray()
    }

    func saveItem(
        item: Item,
        completion: ErrorVoidBlock
    ) {
        do {
            try realm.write {
                realm.add(item)
                completion(nil)
            }
        } catch {
            print("Could not save an item, error:\n\(error)")
            completion(error)
        }
    }

    func remove(
        item: Item,
        completion: ErrorVoidBlock
    ) {
        do {
            try realm.write {
                realm.delete(item)
                completion(nil)
            }
        } catch {
            print("Could not delete an item, error:\n\(error)")
            completion(error)
        }
    }
}
