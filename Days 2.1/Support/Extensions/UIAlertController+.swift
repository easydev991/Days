import UIKit.UIAlertController

extension UIAlertController {
    static func makeAlertWith(
        title: String? = nil,
        message: String? = nil,
        tintColor: UIColor = .textColor,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction]? = nil
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
            title: Text.Button.close.text,
            style: .cancel
        )
        alert.addAction(exit)
        alert.view.tintColor = tintColor
        return alert
    }
}
