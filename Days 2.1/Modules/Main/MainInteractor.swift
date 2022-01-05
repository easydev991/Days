protocol MainInteractorProtocol: AnyObject {
    func saveItem(_ item: Item, completion: OptionalErrorVoidBlock)
    func removeItem(_ item: Item, completion: OptionalErrorVoidBlock)
    func loadItems(sortedBy model: ItemSortModel) -> [Item]
}

final class MainInteractor {
    private let itemStorage: ItemStorageService
    weak var presenter: MainPresenterProtocol?

    init(itemStorage: ItemStorageService) {
        self.itemStorage = itemStorage
    }
}

extension MainInteractor: MainInteractorProtocol {
    func loadItems(sortedBy model: ItemSortModel) -> [Item] {
        itemStorage.loadItems(sortedBy: model)
    }

    func saveItem(
        _ item: Item,
        completion: OptionalErrorVoidBlock
    ) {
        itemStorage.saveItem(item: item) { error in
            completion(error)
        }
    }

    func removeItem(
        _ item: Item,
        completion: OptionalErrorVoidBlock
    ) {
        itemStorage.remove(item: item) { error in
            completion(error)
        }
    }
}
