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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDeleteButtonState()
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func feedbackButtonTapped() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(viewModel.feedbackRecipients)
            mail.setMessageBody(
                viewModel.emailMessageBody,
                isHTML: true
            )
            mail.setSubject(viewModel.emailSubjectText)
            present(mail, animated: true)
        } else {
            presentSimpleAlert(
                title: Text.Alert.error.text,
                message: viewModel.sendEmailErrorMessage,
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
        let yesAction = UIAlertAction(
            title: Text.Button.yes.text,
            style: .destructive,
            handler: { [unowned self] _ in
                viewModel.deleteAllData { result in
                    switch result {
                    case let .success(message):
                        presentSimpleAlert(
                            title: Text.Alert.success.text,
                            message: message
                        )
                        updateDeleteButtonState()
                    case let .failure(error):
                        presentSimpleAlert(
                            title: Text.Alert.error.text,
                            message: error.localizedDescription
                        )
                    }
                }
            }
        )
        let alert = UIAlertController.makeAlert(
            title: Text.Alert.warning.text,
            message: viewModel.deletionDisclaimer,
            style: .alert,
            actions: [yesAction],
            exitStyle: .cancel
        )
        present(alert)
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
        navigationItem.title = viewModel.viewTitle
        view.addSubview(settingsView)
        NSLayoutConstraint.activate(
            [
                settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }

    func updateDeleteButtonState() {
        settingsView.setDeleteAllDataButton(hidden: viewModel.isDeleteButtonHidden)
    }
}
