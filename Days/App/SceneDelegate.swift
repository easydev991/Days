import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupAppearance()
        let window = UIWindow(windowScene: windowScene)
        if CommandLine.arguments.contains("--uitesting") {
            window.layer.speed = 2.0
            DeletionService().clearDatabase()
        }
        window.rootViewController = AppFactory.rootView
        window.makeKeyAndVisible()
        self.window = window
    }
}

private extension SceneDelegate {
    func setupAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.adaptiveText]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.adaptiveText]
        UINavigationBar.appearance().prefersLargeTitles = true
        UITabBar.appearance().tintColor = .sunflower
    }
}
