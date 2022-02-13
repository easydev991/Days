@testable import Days

final class MainInteractorMock: MainInteractorProtocol {
    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        completion(.success(ItemsMock.items))
    }

    func saveItem(_ item: Item, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }

    func removeItem(_ item: Item?, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }
}
