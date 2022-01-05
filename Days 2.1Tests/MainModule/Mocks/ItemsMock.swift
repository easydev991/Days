import Foundation
@testable import Days_2_1

struct ItemsMock {
    static var oneItem: Item {
        Item()
    }

    static var items: [Item] {
        var result = [Item]()
        (.zero...9).forEach { index in
            let newItem = Item()
            newItem.itemName = "Item_\(index)"
            result.append(newItem)
        }
        return result
    }

    static var randomIndex: Int {
        .random(in: .zero...items.count - 1)
    }
}

