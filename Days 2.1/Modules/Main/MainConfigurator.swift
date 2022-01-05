protocol MainConfiguratorProtocol: AnyObject {
    func configure(with viewController: MainViewController)
}

final class MainConfigurator: MainConfiguratorProtocol {
    func configure(with viewController: MainViewController) {
        let itemStorage          = ItemStorage()
        let presenter            = MainPresenter()
        let interactor           = MainInteractor(itemStorage: itemStorage)
        let router               = MainRouter()
        presenter.view           = viewController
        viewController.presenter = presenter
        presenter.interactor     = interactor
        interactor.presenter     = presenter
        presenter.router         = router
        router.viewController    = viewController
    }
}
