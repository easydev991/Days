import UIKit
import StoreKit
import MessageUI

final class SettingsViewController: UIViewController {
    private let viewModel: SettingsViewModelProtocol
    private lazy var settingsView: SettingsView = {
        let view = SettingsView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.settingsView.text
        return view
    }()

    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func feedbackButtonTapped() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(viewModel.feedbackRecipients)
            mail.setMessageBody(
                Text.Settings.feedbackBody.text,
                isHTML: true
            )
            mail.setSubject(Text.Settings.feedbackSubject.text)
            present(mail, animated: true)
        } else {
            showAlertWith(
                title: Text.Alert.errorTitle.text,
                message: "Cannot send emails",
                style: .alert
            )
        }
    }

    func rateButtonTapped() {
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    func deleteAllDataTapped() {
        print("--- deleteAllDataTapped")
        viewModel.deleteAllData()
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true)
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
