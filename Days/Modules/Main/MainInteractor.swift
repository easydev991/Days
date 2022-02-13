protocol MainInteractorProtocol: AnyObject {
    func saveItem(
        _ item: Item,
        completion: @escaping OptionalErrorVoidBlock
    )

    func removeItem(
        _ item: Item?,
        completion: @escaping OptionalErrorVoidBlock
    )

    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    )
}

final class MainInteractor {
    private let itemStorage: ItemStorageService

    init(with itemStorage: ItemStorageService) {
        self.itemStorage = itemStorage
    }
}

extension MainInteractor: MainInteractorProtocol {
    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        itemStorage.loadItems(sortedBy: model, completion: completion)
    }

    func saveItem(
        _ item: Item,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        itemStorage.save(item: item, completion: completion)
    }

    func removeItem(
        _ item: Item?,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        guard let item = item else {
            return
        }
        itemStorage.remove(item: item, completion: completion)
    }
}
