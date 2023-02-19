import UIKit

protocol SettingsViewDelegate: AnyObject {
    func feedbackButtonTapped()
    func rateButtonTapped()
    func deleteAllDataTapped()
}

protocol SettingsViewInput {
    func setDeleteAllDataButton(hidden: Bool)
}

final class SettingsView: UIView {
    private weak var delegate: SettingsViewDelegate?

    private lazy var vStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                feedbackButton,
                rateButton,
                deleteAllDataButton
            ]
        )
        stack.axis = .vertical
        stack.spacing = Layout.Insets.standard
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.vStack.text
        return stack
    }()

    private lazy var feedbackButton: UIButton = {
        let button = UIButton.makeButton(
            title: Text.Settings.sendFeedback.localized
        )
        button.addAction(feedbackAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.feedbackButton.text
        return button
    }()

    private lazy var feedbackAction = UIAction { [weak delegate] _ in
        delegate?.feedbackButtonTapped()
    }

    private lazy var rateButton: UIButton = {
        let button = UIButton.makeButton(
            title: Text.Settings.rateTheApp.localized
        )
        button.addAction(rateAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.rateButton.text
        return button
    }()

    private lazy var rateAction = UIAction { [weak delegate] _ in
        delegate?.rateButtonTapped()
    }

    private lazy var deleteAllDataButton: UIButton = {
        let button = UIButton.makeButton(
            title: Text.Settings.deleteAllData.localized,
            style: .dangerRed
        )
        button.addAction(deleteAllDataAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.deleteDataButton.text
        return button
    }()

    private lazy var deleteAllDataAction = UIAction { [weak delegate] _ in
        delegate?.deleteAllDataTapped()
    }

    init(delegate: SettingsViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView: SettingsViewInput {
    func setDeleteAllDataButton(hidden: Bool) {
        deleteAllDataButton.isHidden = hidden
    }
}

private extension SettingsView {
    enum Identifier: String {
        case vStack, feedbackButton, rateButton, deleteDataButton
        var text: String {
            "SettingsView" + "_" + rawValue
        }
    }

    func setupUI() {
        addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leftAnchor.constraint(equalTo: leftAnchor),
            vStack.rightAnchor.constraint(equalTo: rightAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            feedbackButton.heightAnchor.constraint(equalToConstant: Layout.Button.height)
        ])
    }
}
