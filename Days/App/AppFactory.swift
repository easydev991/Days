import UIKit.UIViewController

struct AppFactory {
    static func makeRootView() -> UIViewController {
        let tabController = UITabBarController()
        let mainView = UINavigationController(rootViewController: MainConfigurator.makeMainVC())
        mainView.tabBarItem = UITabBarItem(title: nil, image: .init(systemName: "house.fill"), tag: .zero)
        let settingsView = UIViewController()
        settingsView.tabBarItem = UITabBarItem(title: nil, image: .init(systemName: "gear"), tag: 1)
        tabController.setViewControllers([mainView, settingsView], animated: true)
        return tabController
    }
}
