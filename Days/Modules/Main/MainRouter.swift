protocol MainRouterProtocol: AnyObject {
    func openItemViewController()
}

final class MainRouter {
    weak var view: MainViewControllerProtocol?
}

extension MainRouter: MainRouterProtocol {
    func openItemViewController() {
        let itemVC = ItemConfigurator.configure(with: view)
        view?.present(itemVC)
    }
}
