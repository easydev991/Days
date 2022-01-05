import UIKit

protocol MainRouterProtocol: AnyObject {
    func openItemViewController()
}

final class MainRouter {
    weak var viewController: MainViewControllerProtocol?
}

extension MainRouter: MainRouterProtocol {
    func openItemViewController() {
        let itemViewController = ItemViewController()
        itemViewController.delegate = viewController
        viewController?.present(itemViewController)
    }
}
