protocol MainInteractorProtocol: AnyObject {
    var itemsCount: Int { get }

    func saveItem(
        _ item: Item,
        completion: @escaping OptionalErrorVoidBlock
    )

    func removeItem(
        _ item: Item,
        completion: @escaping OptionalErrorVoidBlock
    )

    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    )
}

final class MainInteractor {
    private let itemStorage: ItemStorageService

    init(itemStorage: ItemStorageService) {
        self.itemStorage = itemStorage
    }
}

extension MainInteractor: MainInteractorProtocol {
    var itemsCount: Int {
        itemStorage.itemsCount
    }

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
        _ item: Item,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        itemStorage.remove(item: item, completion: completion)
    }
}
