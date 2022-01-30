@testable import Days_2_1

final class MainInteractorMock: MainInteractorProtocol {
    private var _itemsCount = 0
    private let defaultSort = SortBy.dateAscending
    var isSorted = false

    var itemsCount: Int { _itemsCount }

    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        if model.sorting != defaultSort {
            isSorted.toggle()
        }
        _itemsCount += ItemsMock.itemsCount
        completion(.success(ItemsMock.items))
    }

    func saveItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        _itemsCount += 1
        completion(nil)
    }

    func removeItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        _itemsCount -= 1
        completion(nil)
    }
}
