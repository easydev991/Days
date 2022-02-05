import UIKit

protocol EmptyViewDelegate: AnyObject {
    func buttonTapped()
}

final class EmptyView: UIView {
    private weak var delegate: EmptyViewDelegate?

    // MARK: - UI
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                addNewItemButton
            ]
        )
        stack.axis = .vertical
        stack.spacing = Layout.Insets.standard
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.vStack.text
        return stack
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.Main.emptyList.text
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.textColor = .adaptiveText
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.titleLabel.text
        return label
    }()
    private lazy var addNewItemButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.setTitle(Text.Item.viewTitle.text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setBackgroundImage(
            .init(color: .sunflower),
            for: .normal
        )
        button.setBackgroundImage(
            .init(color: .sunflowerPressed),
            for: .highlighted
        )
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blackPressed, for: .highlighted)
        button.layer.cornerRadius = 24
        button.contentEdgeInsets = .init(
            top: .zero,
            left: Layout.Insets.standard,
            bottom: .zero,
            right: Layout.Insets.standard
        )
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = Identifier.addNewItemButton.text
        return button
    }()

    // MARK: - Lifecycle
    init(delegate: EmptyViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private extension
private extension EmptyView {
    enum Identifier: String {
        case vStack, titleLabel, addNewItemButton
        var text: String {
            "EmptyView" + "_" + self.rawValue
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
                addNewItemButton.heightAnchor.constraint(equalToConstant: Layout.Button.height)
            ]
        )
    }

    @objc func buttonTapped() {
        delegate?.buttonTapped()
    }
}
