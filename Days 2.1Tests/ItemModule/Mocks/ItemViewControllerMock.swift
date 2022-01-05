import UIKit
@testable import Days_2_1

final class ItemViewControllerMock  {
    var delegate: ItemViewControllerDelegate!
    var savedItem = false
    var saveButtonEnabled = false
}

extension ItemViewControllerMock: ItemViewControllerProtocol {
    func saveAction() {
        savedItem.toggle()
    }

    func setSaveButton(enabled: Bool) {
        saveButtonEnabled = enabled
    }
}
