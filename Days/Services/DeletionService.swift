import RealmSwift

protocol DeletionServiceProtocol {
    func clearDatabase(completion: OptionalErrorVoidBlock?)
}

final class DeletionService: DeletionServiceProtocol {
    func clearDatabase(completion: OptionalErrorVoidBlock? = nil) {
        do {
            let realm = try Realm(
                configuration: .init(
                    schemaVersion: RealmSchema.version
                )
            )
            try realm.write {
                realm.deleteAll()
            }
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
}
