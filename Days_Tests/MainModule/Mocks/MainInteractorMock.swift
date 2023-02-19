@testable import Days

final class MainInteractorMock: MainInteractorProtocol {
    func loadItems(
        sortedBy _: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        completion(.success(ItemsMock.items))
    }

    func saveItem(_: Item, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }

    func removeItem(_: Item?, completion: OptionalErrorVoidBlock) {
        completion(nil)
    }
}
