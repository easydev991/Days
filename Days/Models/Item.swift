import Foundation
import RealmSwift

final class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var date = Date()

    convenience init(title: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
    }
}
