@testable import Days

final class ItemStorageMock: ItemStorageService {
    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        completion(.success(ItemsMock.items))
    }

    func save(
        item: Item,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        completion(nil)
    }

    func remove(
        item: Item,
        completion: (Error?) -> Void
    ) {
        completion(nil)
    }
}
