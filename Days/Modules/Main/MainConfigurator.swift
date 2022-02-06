import UIKit.UIViewController

final class MainConfigurator {
    static func makeMainVC() -> UIViewController {
        let mainVC            = MainViewController()
        let storage           = ItemStorage()
        let presenter         = MainPresenter()
        let interactor        = MainInteractor(itemStorage: storage)
        let router            = MainRouter()
        presenter.view        = mainVC
        mainVC.presenter      = presenter
        presenter.interactor  = interactor
        presenter.router      = router
        router.view           = mainVC

        return mainVC
    }
}
