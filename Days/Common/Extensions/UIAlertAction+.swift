import UIKit.UIAlertController

extension UIAlertAction {
    enum ExitStyle {
        case close, cancel
        var type: Text.Button {
            self == .close ? .close : .cancel
        }
    }

    static func exitAction(with style: ExitStyle) -> UIAlertAction {
        .init(title: style.type.text, style: .cancel)
    }
}
