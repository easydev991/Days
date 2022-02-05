import UIKit
@testable import Days

final class MainViewControllerMock {
    var title: String? = nil
    var reloadComplete = false
    var isEmptyViewHidden = false
    var isErrorShown = false
    var isItemsViewPresented = false
    var errorMessage = String()
    var visibleNavItemButtons = MainViewController.VisibleNavItemButtons.none
}

extension MainViewControllerMock: MainViewControllerProtocol {
    func reload(isListEmpty: Bool) {
        reloadComplete.toggle()
    }

    func set(title: String?) {
        self.title = title
    }

    func setEmptyView(hidden: Bool) {
        isEmptyViewHidden = hidden
    }

    func setNavItemButtons(
        _ state: MainViewController.VisibleNavItemButtons
    ) {
        visibleNavItemButtons = state
    }

    func showError(_ message: String) {
        isErrorShown.toggle()
        errorMessage = message
    }

    func takeItem(with name: String, and date: Date) {}

    func present(_ viewController: UIViewController) {
        isItemsViewPresented.toggle()
    }
}
