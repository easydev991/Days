import UIKit
import StoreKit

final class SettingsViewController: UIViewController {
    private lazy var settingsView: SettingsView = {
        let view = SettingsView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.settingsView.text
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func feedbackButtonTapped() {
        print("--- feedbackButtonTapped")
    }

    func rateButtonTapped() {
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    func deleteAllDataTapped() {
        print("--- deleteAllDataTapped")
    }
}

private extension SettingsViewController {
    enum Identifier: String {
        case rootView, settingsView
        var text: String {
            "SettingsVC" + "_" + self.rawValue
        }
    }

    func setupUI() {
        view.accessibilityIdentifier = Identifier.rootView.text
        navigationItem.title = Text.Settings.viewTitle.text
        view.addSubview(settingsView)
        NSLayoutConstraint.activate(
            [
                settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
}
