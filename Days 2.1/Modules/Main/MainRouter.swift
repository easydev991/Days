import UIKit

protocol MainRouterProtocol: AnyObject {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

final class MainRouter {
    weak var viewController: MainViewControllerProtocol?
}

extension MainRouter: MainRouterProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ItemViewController {
            vc.delegate = viewController
        }
    }
}
