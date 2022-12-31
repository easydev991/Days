import UIKit

protocol EmptyViewDelegate: AnyObject {
    func buttonTapped()
}

final class EmptyView: UIView {
    private weak var delegate: EmptyViewDelegate?

    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, addNewItemButton])
        stack.axis = .vertical
        stack.spacing = Layout.Insets.standard
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.vStack.text
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.Main.emptyList.localized
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.textColor = .adaptiveText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.titleLabel.text
        return label
    }()

    private lazy var addNewItemButton: UIButton = {
        let button = UIButton.makeButton(
            title: Text.Item.viewTitle.localized
        )
        button.addAction(addAction, for: .touchUpInside)
        button.accessibilityIdentifier = Identifier.addNewItemButton.text
        return button
    }()

    private lazy var addAction = UIAction { [weak delegate] _ in
        delegate?.buttonTapped()
    }

    init(delegate: EmptyViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension EmptyView {
    enum Identifier: String {
        case vStack, titleLabel, addNewItemButton
        var text: String {
            "EmptyView" + "_" + self.rawValue
        }
    }

    func setupUI() {
        addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leftAnchor.constraint(equalTo: leftAnchor),
            vStack.rightAnchor.constraint(equalTo: rightAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            addNewItemButton.heightAnchor.constraint(equalToConstant: Layout.Button.height)
        ])
    }
}
