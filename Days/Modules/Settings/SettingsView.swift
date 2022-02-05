import UIKit

protocol SettingsViewDelegate: AnyObject {
    func feedbackButtonTapped()
    func rateButtonTapped()
    func deleteAllDataTapped()
}

final class SettingsView: UIView {
    private weak var delegate: SettingsViewDelegate?

    private let canDeleteAllData: Bool

    // MARK: - UI
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                feedbackButton,
                rateButton
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
        let button = UIButton.customWith(
            title: Text.Settings.sendFeedback.text
        )
        button.addAction(feedbackAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.feedbackButton.text
        return button
    }()
    private lazy var feedbackAction = UIAction { [weak delegate] _ in
        delegate?.feedbackButtonTapped()
    }
    private lazy var rateButton: UIButton = {
        let button = UIButton.customWith(
            title: Text.Settings.rateTheApp.text
        )
        button.addAction(rateAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.rateButton.text
        return button
    }()
    private lazy var rateAction = UIAction { [weak delegate] _ in
        delegate?.rateButtonTapped()
    }
    private lazy var deleteAllDataButton: UIButton = {
        let button = UIButton.customWith(
            title: Text.Settings.deleteAllData.text,
            style: .dangerRed
        )
        button.addAction(deleteAllDataAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.rateButton.text
        return button
    }()
    private lazy var deleteAllDataAction = UIAction { [weak delegate] _ in
        delegate?.deleteAllDataTapped()
    }

    // MARK: - Lifecycle
    init(
        delegate: SettingsViewDelegate?,
        canDeleteAllData: Bool
    ) {
        self.delegate = delegate
        self.canDeleteAllData = canDeleteAllData
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingsView {
    enum Identifier: String {
        case vStack, feedbackButton, rateButton, deleteDataButton
        var text: String {
            "SettingsView" + "_" + self.rawValue
        }
    }

    func setupUI() {
        addSubview(vStack)
        NSLayoutConstraint.activate(
            [
                vStack.topAnchor.constraint(equalTo: topAnchor),
                vStack.leftAnchor.constraint(equalTo: leftAnchor),
                vStack.rightAnchor.constraint(equalTo: rightAnchor),
                vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
                feedbackButton.heightAnchor.constraint(equalToConstant: Layout.Button.height)
            ]
        )
        if canDeleteAllData {
            vStack.addArrangedSubview(deleteAllDataButton)
        }
    }
}
