import UIKit

final class SettingsViewController: UIViewController {
    private lazy var settingsView: SettingsView = {
        let view = SettingsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.settingsView.text
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
