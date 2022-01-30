import UIKit
@testable import Days_2_1

final class ItemViewControllerMock  {
    var delegate: ItemViewControllerDelegate!
    var saveButtonEnabled = false
}

extension ItemViewControllerMock: ItemViewControllerProtocol {
    func saveAction() {}

    func setSaveButton(enabled: Bool) {
        saveButtonEnabled = enabled
    }

    func dismiss() {}
}
