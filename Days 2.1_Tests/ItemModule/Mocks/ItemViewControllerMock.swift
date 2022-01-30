import UIKit
@testable import Days_2_1

final class ItemViewControllerMock  {
    var delegate: ItemViewControllerDelegate!
    var isItemSaved = false
    var saveButtonEnabled = false
    var isDismissed = false
}

extension ItemViewControllerMock: ItemViewControllerProtocol {
    func saveAction() {
        isItemSaved.toggle()
    }

    func setSaveButton(enabled: Bool) {
        saveButtonEnabled = enabled
    }

    func dismiss() {
        isDismissed.toggle()
    }
}
