import Foundation
@testable import Days

struct ItemsMock {
    static var oneItem = Item(title: "", date: Date())
    static var items: [Item] {
        var result = [Item]()
        (.zero...9).forEach { index in
            let newItem = Item(title: "Item_\(index)", date: Date())
            result.append(newItem)
        }
        return result
    }
    static var itemsCount = items.count
    static var randomIndex: Int {
        .random(in: .zero...itemsCount - 1)
    }
}

