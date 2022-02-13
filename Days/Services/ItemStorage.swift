import RealmSwift

protocol ItemStorageService {
    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    )

    func save(
        item: Item,
        completion: @escaping OptionalErrorVoidBlock
    )

    func remove(
        item: Item,
        completion: @escaping OptionalErrorVoidBlock
    )
}

final class ItemStorage {
    private let realmConfig = Realm.Configuration(
        schemaVersion: RealmSchema.version
    )
}

extension ItemStorage: ItemStorageService {
    func loadItems(
        sortedBy model: ItemSortModel,
        completion: @escaping ItemsVoidResult
    ) {
        do {
            let realm = try Realm(configuration: realmConfig)
            let items = realm.objects(Item.self)
                .sorted(
                    byKeyPath: model.sortBy.rawValue,
                    ascending: model.ascending
                )
                .toArray()
            completion(.success(items))
        } catch {
            completion(.failure(error))
        }
    }

    func save(
        item: Item,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        do {
            let realm = try Realm(configuration: realmConfig)
            try realm.write {
                realm.add(item)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }

    func remove(
        item: Item,
        completion: @escaping OptionalErrorVoidBlock
    ) {
        do {
            let realm = try Realm(configuration: realmConfig)
            try realm.write {
                realm.delete(item)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
