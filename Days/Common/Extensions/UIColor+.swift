import UIKit.UIColor

extension UIColor {
    static let mainBackground   = UIColor(named: "MainBackgroundColor")!
    static let buttonTint       = UIColor(named: "ButtonTintColor")!
    static let adaptiveText     = UIColor(named: "AdaptiveText")!
    static let sunflower        = UIColor(named: "Sunflower")!
    static let sunflowerPressed = sunflower.withAlphaComponent(0.8)
    static let blackPressed     = UIColor.black.withAlphaComponent(0.8)
}
