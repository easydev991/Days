import Foundation
@testable import Days_2_1

struct ItemsMock {
    static var oneItem = Item()
    static var items: [Item] {
        var result = [Item]()
        (.zero...9).forEach { index in
            let newItem = Item()
            newItem.title = "Item_\(index)"
            result.append(newItem)
        }
        return result
    }
    static var itemsCount = items.count
    static var randomIndex: Int {
        .random(in: .zero...itemsCount - 1)
    }
}

