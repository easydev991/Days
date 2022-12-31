import UIKit

final class AppFactory {
    static var rootView: UIViewController {
        let tabController = UITabBarController()
        let mainVC = MainConfigurator.mainVC
        mainVC.tabBarItem = .init(
            title: nil,
            image: Images.TabBar.home.image,
            tag: .zero
        )
        let settingsVC = SettingsConfigurator.settingsVC
        settingsVC.tabBarItem = .init(
            title: nil,
            image: Images.TabBar.settings.image,
            tag: 1
        )
        let controllers = [mainVC, settingsVC].map { UINavigationController(rootViewController: $0) }
        tabController.setViewControllers(controllers, animated: true)
        return tabController
    }
}
