import Foundation
@testable import Days_2_1

final class MainInteractorMock: MainInteractorProtocol {
    func loadItems(sortedBy model: ItemSortModel) -> [Item] {
        ItemsMock.items
    }

    func saveItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }

    func removeItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }
}
