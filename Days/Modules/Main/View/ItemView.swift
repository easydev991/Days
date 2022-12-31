import UIKit

protocol ItemViewInput {
    func set(title: String, daysText: String)
}

final class ItemView: UIView {
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Layout.Insets.average
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.container.text
        return view
    }()

    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, daysLabel])
        stack.spacing = Layout.Insets.standard
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.hStack.text
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.titleLabel.text
        return label
    }()
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.daysLabel.text
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ItemView: ItemViewInput {
    func set(title: String, daysText: String) {
        titleLabel.text = title
        daysLabel.text = daysText
    }
}

private extension ItemView {
    enum Identifier: String {
        case container, hStack, titleLabel, daysLabel
        var text: String {
            "ItemView" + "_" + self.rawValue
        }
    }

    func setupUI() {
        container.addSubview(hStack)
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leftAnchor.constraint(equalTo: leftAnchor),
            container.rightAnchor.constraint(equalTo: rightAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            hStack.topAnchor.constraint(
                equalTo: container.topAnchor,
                constant: Layout.Insets.standard
            ),
            hStack.leftAnchor.constraint(
                equalTo: container.leftAnchor,
                constant: Layout.Insets.standard
            ),
            hStack.rightAnchor.constraint(
                equalTo: container.rightAnchor,
                constant: -Layout.Insets.standard
            ),
            hStack.bottomAnchor.constraint(
                equalTo: container.bottomAnchor,
                constant: -Layout.Insets.standard
            ),
            daysLabel.widthAnchor.constraint(
                lessThanOrEqualTo: container.widthAnchor,
                multiplier: 0.3
            )
        ])
    }
}
