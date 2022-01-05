import UIKit

extension UIDatePicker {
    var textColor: UIColor? {
        get { value(forKeyPath: "textColor") as? UIColor }
        set { setValue(newValue, forKeyPath: "textColor") }
    }

    var highlightsToday: Bool? {
        get { value(forKeyPath: "highlightsToday") as? Bool }
        set { setValue(newValue, forKey: "highlightsToday") }
    }
}
