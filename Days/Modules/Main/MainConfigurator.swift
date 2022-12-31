import UIKit.UIViewController

final class MainConfigurator {
    static var mainVC: UIViewController {
        let view             = MainViewController()
        let dataSource       = MainDataSource()
        let storage          = ItemStorage()
        let presenter        = MainPresenter(with: dataSource)
        let interactor       = MainInteractor(with: storage)
        let router           = MainRouter()
        presenter.view       = view
        view.presenter       = presenter
        presenter.interactor = interactor
        presenter.router     = router
        router.view          = view
        return view
    }
}
