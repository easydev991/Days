import Foundation
@testable import Days

enum ItemsMock: Sendable {
    static let oneItem = Item(title: "", date: .now)

    static let items = (.zero...9).map { Item(title: "Item_\($0)", date: .now) }

    static var randomIndex: Int { .random(in: .zero...items.count - 1) }
}

