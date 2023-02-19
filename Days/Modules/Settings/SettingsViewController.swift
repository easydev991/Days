import MessageUI
import StoreKit
import UIKit

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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
            viewModel.sendFeedback()
        } else {
            presentSimpleAlert(
                title: Text.Alert.error.localized,
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
            title: Text.Button.yes.localized,
            style: .destructive
        ) { [unowned self] _ in
            viewModel.deleteAllData { result in
                switch result {
                case let .success(message):
                    self.presentSimpleAlert(
                        title: Text.Alert.success.localized,
                        message: message
                    )
                    self.updateDeleteButtonState()
                case let .failure(error):
                    self.presentSimpleAlert(
                        title: Text.Alert.error.localized,
                        message: error.localizedDescription
                    )
                }
            }
        }
        let alert = UIAlertController.makeAlert(
            title: Text.Alert.warning.localized,
            message: viewModel.deletionDisclaimer,
            style: .alert,
            actions: [yesAction],
            exitStyle: .cancel
        )
        present(alert)
    }
}

private extension SettingsViewController {
    enum Identifier: String {
        case rootView, settingsView
        var text: String {
            "SettingsVC" + "_" + rawValue
        }
    }

    func setupUI() {
        view.accessibilityIdentifier = Identifier.rootView.text
        navigationItem.title = viewModel.viewTitle
        view.addSubview(settingsView)
        NSLayoutConstraint.activate([
            settingsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func updateDeleteButtonState() {
        settingsView.setDeleteAllDataButton(hidden: viewModel.isDeleteButtonHidden)
    }
}
