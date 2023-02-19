@testable import Days

final class ItemStorageMock: ItemStorageService {
    func loadItems(sortedBy _: ItemSortModel, completion: @escaping ItemsVoidResult) {
        completion(.success(ItemsMock.items))
    }

    func save(item _: Item, completion: @escaping OptionalErrorVoidBlock) {
        completion(nil)
    }

    func remove(item _: Item, completion: (Error?) -> Void) {
        completion(nil)
    }
}
