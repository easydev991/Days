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
