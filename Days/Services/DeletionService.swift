import RealmSwift

protocol DeletionServiceProtocol {
    func clearDatabase()
}

extension DeletionServiceProtocol {
    func clearDatabase() {
        do {
            let realm = try Realm(
                configuration: .init(
                    schemaVersion: RealmSchema.version
                )
            )
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(
                "DeletionServiceProtocol: clearDatabase:",
                error.localizedDescription
            )
        }
    }
}

struct DeletionService: DeletionServiceProtocol {}
