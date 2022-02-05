import UIKit
import RealmSwift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if CommandLine.arguments.contains("--uitesting") {
            UIView.setAnimationsEnabled(false)
            clearDatabaseForUITesting()
        }
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

private extension AppDelegate {
    func clearDatabaseForUITesting() {
        do {
            let realm = try Realm(
                configuration: .init(
                    schemaVersion: RealmSchema.version
                )
            )
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(
                "AppDelegate: clearDatabaseForUITesting:",
                error.localizedDescription
            )
        }
    }
}
