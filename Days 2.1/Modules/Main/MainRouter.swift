protocol MainRouterProtocol: AnyObject {
    func openItemViewController()
}

final class MainRouter {
    weak var viewController: MainViewControllerProtocol?
}

extension MainRouter: MainRouterProtocol {
    func openItemViewController() {
        let itemVC = ItemConfigurator.configure(with: viewController)
        viewController?.present(itemVC)
    }
}
