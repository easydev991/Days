import RealmSwift

extension Results {
    func toArray() -> [Element] {
        compactMap { $0 }
    }
}
