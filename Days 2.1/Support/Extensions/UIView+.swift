import UIKit.UIView

extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }

    func fadeIn(_ duration: TimeInterval = 0.3) {
        fadeTo(1, duration: duration)
    }
}
