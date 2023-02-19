@testable import Days
import Foundation

enum ItemsMock: Sendable {
    static let oneItem = Item(title: "", date: .init())

    static let items = (.zero ... 9).map { Item(title: "Item_\($0)", date: .init()) }

    static var randomIndex: Int { .random(in: .zero ... items.count - 1) }
}
