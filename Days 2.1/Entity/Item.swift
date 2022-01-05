import Foundation
import RealmSwift

final class Item: Object {
    @objc dynamic var itemName = ""
    @objc dynamic var date = Date()
}
