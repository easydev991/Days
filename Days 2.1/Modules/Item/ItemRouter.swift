import UIKit

protocol ItemRouterProtocol: AnyObject {
    func closeCurrentViewController()
}

final class ItemRouter {
    weak var viewController: ItemViewController?
}

extension ItemRouter: ItemRouterProtocol {
    func closeCurrentViewController() {
        viewController?.dismiss(animated: true)
    }
}
