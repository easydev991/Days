import UIKit

protocol MainRouterProtocol: AnyObject {
    func prepare(for controller: UIViewController?)
}

final class MainRouter {
    weak var viewController: MainViewControllerProtocol?
}

extension MainRouter: MainRouterProtocol {
    func prepare(for controller: UIViewController?) {
        if let vc = controller as? ItemViewController {
            vc.delegate = viewController
        }
    }
}
