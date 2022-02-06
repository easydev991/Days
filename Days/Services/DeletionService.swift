import RealmSwift

protocol DeletionServiceProtocol {
    var isDataAvailable: Bool { get }
    func clearDatabase(completion: OptionalErrorVoidBlock?)
}

final class DeletionService {
    private let realmConfig = Realm.Configuration(
        schemaVersion: RealmSchema.version
    )
}

extension DeletionService: DeletionServiceProtocol {
    var isDataAvailable: Bool {
        do {
            let realm = try Realm(configuration: realmConfig)
            return !realm.objects(Item.self).isEmpty
        } catch {
            return false
        }
    }

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
