//
//  MainInteractorMock.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import Foundation
@testable import Days_2_1

final class MainInteractorMock: MainInteractorProtocol {
    func saveItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }

    func removeItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }

    func loadItems(sortedBy: ItemsSort, ascending: Bool) -> [Item] {
        ItemsMock.items
    }
}
