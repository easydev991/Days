import UIKit

protocol ItemRouterProtocol: AnyObject {
    func dismissViewController()
}

final class ItemRouter {
    weak var viewController: ItemViewControllerProtocol?
}

extension ItemRouter: ItemRouterProtocol {
    func dismissViewController() {
        viewController?.dismiss()
    }
}
