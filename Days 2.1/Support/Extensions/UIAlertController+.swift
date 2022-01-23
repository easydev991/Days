import UIKit.UIAlertController

extension UIAlertController {
    enum ExitButton {
        case cancel, close

        var title: String {
            self == .cancel
            ? Text.Button.cancel.text
            : Text.Button.close.text
        }
    }

    static func makeAlertWith(
        title: String? = nil,
        message: String? = nil,
        tintColor: UIColor = .textColor,
        style: UIAlertController.Style,
        actions: [UIAlertAction]? = nil,
        exitButton button: ExitButton
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        if let actions = actions {
            actions.forEach {
                alert.addAction($0)
            }
        }
        let exit = UIAlertAction(
            title: button.title,
            style: .cancel
        )
        alert.addAction(exit)
        alert.view.tintColor = tintColor
        return alert
    }
}
