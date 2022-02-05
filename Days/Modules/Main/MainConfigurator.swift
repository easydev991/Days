import UIKit.UIViewController

struct MainConfigurator {
    static func makeMainVC() -> UIViewController {
        let mainVC            = MainViewController()
        let storage           = ItemStorage()
        let presenter         = MainPresenter()
        let interactor        = MainInteractor(itemStorage: storage)
        let router            = MainRouter()
        presenter.view        = mainVC
        mainVC.presenter      = presenter
        presenter.interactor  = interactor
        interactor.presenter  = presenter
        presenter.router      = router
        router.viewController = mainVC

        return mainVC
    }
}
