@testable import Days
import UIKit

final class MainViewControllerMock {
    var title: String?
    var reloadComplete = false
    var isEmptyViewHidden = false
    var isErrorShown = false
    var isItemsViewPresented = false
    var errorMessage = ""
    var visibleNavItemButtons = MainViewController.VisibleNavItemButtons.none
}

extension MainViewControllerMock: MainViewControllerProtocol {
    func reload(isListEmpty _: Bool) {
        reloadComplete.toggle()
    }

    func set(title: String?) {
        self.title = title
    }

    func setEmptyView(hidden: Bool) {
        isEmptyViewHidden = hidden
    }

    func setNavItemButtons(_ state: MainViewController.VisibleNavItemButtons) {
        visibleNavItemButtons = state
    }

    func showError(_ message: String) {
        isErrorShown.toggle()
        errorMessage = message
    }

    func takeItem(with _: String, and _: Date) {}

    func present(_: UIViewController) {
        isItemsViewPresented.toggle()
    }
}
