import Foundation
import RealmSwift

final class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
}
