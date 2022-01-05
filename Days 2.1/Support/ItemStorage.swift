import Foundation
import RealmSwift

protocol ItemStorageService {
    func loadItems(sortedBy model: ItemSortModel) -> [Item]

    func saveItem(
        item: Item,
        completion: OptionalErrorVoidBlock
    )

    func remove(
        item: Item,
        completion: OptionalErrorVoidBlock
    )
}

final class ItemStorage {
    private let realm = try! Realm()
}

extension ItemStorage: ItemStorageService {
    func loadItems(sortedBy model: ItemSortModel) -> [Item] {
        realm
            .objects(Item.self)
            .sorted(
                byKeyPath: model.sortBy.rawValue,
                ascending: model.ascending
            )
            .toArray()
    }

    func saveItem(
        item: Item,
        completion: OptionalErrorVoidBlock
    ) {
        do {
            try realm.write {
                realm.add(item)
                completion(nil)
            }
        } catch {
            print("Could not save an item, error:\n\(error)")
            completion(error)
        }
    }

    func remove(
        item: Item,
        completion: OptionalErrorVoidBlock
    ) {
        do {
            try realm.write {
                realm.delete(item)
                completion(nil)
            }
        } catch {
            print("Could not delete an item, error:\n\(error)")
            completion(error)
        }
    }
}
