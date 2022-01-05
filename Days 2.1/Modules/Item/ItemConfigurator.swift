struct ItemConfigurator {
    static func configure(with viewController: ItemViewController) {
        let presenter            = ItemPresenter()
        let interactor           = ItemInteractor()
        let router               = ItemRouter()
        presenter.view           = viewController
        viewController.presenter = presenter
        presenter.interactor     = interactor
        interactor.presenter     = presenter
        presenter.router         = router
        router.viewController    = viewController
    }
}
