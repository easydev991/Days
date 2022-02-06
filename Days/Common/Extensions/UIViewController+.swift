import UIKit.UIViewController

extension UIViewController {
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func presentSimpleAlert(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) {
        let alert = UIAlertController.makeAlert(
            title: title,
            message: message,
            style: style
        )
        present(alert)
    }
}
