@testable import Days_2_1

final class ItemStorageMock: ItemStorageService {
    private var _itemsCount = 0

    var itemsCount: Int { _itemsCount }

    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        _itemsCount += ItemsMock.itemsCount
        completion(.success(ItemsMock.items))
    }

    func save(
        item: Item,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        _itemsCount += 1
        completion(nil)
    }

    func remove(
        item: Item,
        completion: (Error?) -> Void
    ) {
        _itemsCount -= 1
        completion(nil)
    }
}
