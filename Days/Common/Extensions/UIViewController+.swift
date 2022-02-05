import UIKit.UIViewController

extension UIViewController {
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func showAlertWith(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) {
        let alert = UIAlertController.makeAlertWith(
            title: Text.Alert.errorTitle.text,
            message: message,
            style: style
        )
        present(alert)
    }
}
