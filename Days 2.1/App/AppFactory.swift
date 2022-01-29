import UIKit.UIViewController

struct AppFactory {
    static func makeRootView() -> UIViewController {
        let mainView = MainConfigurator.makeMainVC()
        return UINavigationController(rootViewController: mainView)
    }
}
