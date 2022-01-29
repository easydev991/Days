struct ItemConfigurator {
    static func configure(
        with delegate: ItemViewControllerDelegate?
    ) -> ItemViewController {
        let itemVC               = ItemViewController()
        itemVC.delegate          = delegate
        let presenter            = ItemPresenter()
        let router               = ItemRouter()
        presenter.view           = itemVC
        itemVC.presenter         = presenter
        presenter.router         = router
        router.viewController    = itemVC

        return itemVC
    }
}
