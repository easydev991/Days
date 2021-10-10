//
//  ItemStorageMock.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import Foundation
@testable import Days_2_1

final class ItemStorageMock: ItemStorageService {
    func loadItems(sortedBy: ItemsSort, ascending: Bool) -> [Item] {
        ItemsMock.items
    }

    func saveItem(item: Item, completion: (Error?) -> Void) {
        completion(nil)
    }

    func remove(item: Item, completion: (Error?) -> Void) {
        completion(nil)
    }
}
