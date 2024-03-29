import Foundation
import RealmSwift

final class Item: Object {
    @Persisted var title = ""
    @Persisted var date = Date()

    convenience init(title: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
    }
}
