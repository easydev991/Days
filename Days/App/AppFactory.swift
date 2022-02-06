import UIKit.UIViewController

final class AppFactory {
    static func makeRootView() -> UIViewController {
        let tabController = UITabBarController()
        let mainVC = MainConfigurator.makeVC()
        mainVC.tabBarItem = .init(
            title: nil,
            image: Images.TabBar.home.image,
            tag: .zero
        )
        let settingsVC = SettingsConfigurator.makeVC()
        settingsVC.tabBarItem = .init(
            title: nil,
            image: Images.TabBar.settings.image,
            tag: 1
        )
        let controllers = [mainVC, settingsVC].map(UINavigationController.init)
        tabController.setViewControllers(controllers, animated: true)
        return tabController
    }
}
