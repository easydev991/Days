@testable import Days
import UIKit

final class ItemViewControllerMock {
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
