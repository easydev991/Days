import UIKit.UIViewController

struct AppFactory {
    static func makeRootView() -> UIViewController {
        let tabController = UITabBarController()
        let mainView = UINavigationController(
            rootViewController: MainConfigurator.makeMainVC()
        )
        mainView.tabBarItem = UITabBarItem(title: nil, image: Images.TabBar.home.image, tag: .zero)
        let settingsView = UINavigationController(rootViewController: SettingsConfigurator.makeSettingsVC())
        settingsView.tabBarItem = UITabBarItem(title: nil, image: Images.TabBar.settings.image, tag: 1)
        tabController.setViewControllers([mainView, settingsView], animated: true)
        return tabController
    }
}
