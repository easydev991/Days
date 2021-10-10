//
//  ItemsMock.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import Foundation
@testable import Days_2_1

struct ItemsMock {
    static func makeItems() -> [Item] {
        var result = [Item]()
        (.zero...10).forEach { index in
            let newItem = Item()
            newItem.itemName = "Item_\(index)"
            result.append(newItem)
        }
        return result
    }
}

