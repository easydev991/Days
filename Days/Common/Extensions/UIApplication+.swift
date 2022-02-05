import UIKit.UIApplication

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes.first(
            where: { $0.activationState == .foregroundActive }
        ) as? UIWindowScene
    }
}
