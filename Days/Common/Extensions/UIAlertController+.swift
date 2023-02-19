import UIKit.UIAlertController

extension UIAlertController {
    static func makeAlert(
        title: String? = nil,
        message: String? = nil,
        tintColor: UIColor = .adaptiveText,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction]? = nil,
        exitStyle: UIAlertAction.ExitStyle = .close
    ) -> UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        if let actions {
            actions.forEach {
                alert.addAction($0)
            }
        }
        let exit = UIAlertAction.exitAction(with: exitStyle)
        alert.addAction(exit)
        alert.view.tintColor = tintColor
        return alert
    }
}
