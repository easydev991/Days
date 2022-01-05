import UIKit

protocol ItemRouterProtocol: AnyObject {
    func dismissViewController()
}

final class ItemRouter {
    weak var viewController: ItemViewController?
}

extension ItemRouter: ItemRouterProtocol {
    func dismissViewController() {
        viewController?.dismiss(animated: true)
    }
}
