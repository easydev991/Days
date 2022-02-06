import UIKit.UIAlertController

extension UIAlertAction {
    enum ExitStyle {
        case close, cancel
        var title: String {
            self == .close
            ? Text.Button.close.text
            : Text.Button.cancel.text
        }
    }

    static func exitAction(with style: ExitStyle) -> UIAlertAction {
        .init(title: style.title, style: .cancel)
    }
}
