import UIKit.UIViewController

struct MainConfigurator {
    static func makeMainVC() -> UIViewController {
        let mainVC            = MainViewController()
        let itemStorage       = ItemStorage()
        let presenter         = MainPresenter()
        let interactor        = MainInteractor(itemStorage: itemStorage)
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
