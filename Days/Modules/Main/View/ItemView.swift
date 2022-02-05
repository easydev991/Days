import UIKit

final class ItemView: UIView {
    // MARK: - UI
    private lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Layout.Insets.average
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.container.text
        return view
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel, daysLabel
            ]
        )
        stack.spacing = Layout.Insets.standard
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.hStack.text
        return stack
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.titleLabel.text
        return label
    }()
    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.daysLabel.text
        return label
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - ItemCellInput
extension ItemView: ItemCellInput {
    func setup(with model: ItemCell.Model) {
        titleLabel.text = model.itemName
        daysLabel.text = model.itemDays
    }
}

// MARK: - Private extension
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
        NSLayoutConstraint.activate(
            [
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
            ]
        )
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
import SwiftUI

struct ItemViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> ItemView {
        let view = ItemView()
        let itemData = ItemCell.Model(
            itemName: "Made my first app for iOS device",
            itemDays: "999 days"
        )
        view.setup(with: itemData)
        return view
    }

    func updateUIView(_ uiView: ItemView, context: Context) {}
}

struct ItemViewPreview: PreviewProvider {
    static var previews: some View {
        ItemViewRepresentable()
    }
}
#endif
