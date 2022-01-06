import UIKit

final class ItemView: UIView {
    // MARK: - UI
    private lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                itemNameLabel, itemDaysLabel
            ]
        )
        stack.spacing = 16
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var itemDaysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
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
        itemNameLabel.text = model.itemName
        itemDaysLabel.text = model.itemDays
    }
}

// MARK: - Private extension
private extension ItemView {
    func setupUI() {
        backgroundColor = .clear
        container.addSubview(horizontalStack)
        addSubview(container)
        NSLayoutConstraint.activate(
            [
                container.topAnchor.constraint(equalTo: topAnchor),
                container.leftAnchor.constraint(equalTo: leftAnchor),
                container.rightAnchor.constraint(equalTo: rightAnchor),
                container.bottomAnchor.constraint(equalTo: bottomAnchor),
                horizontalStack.topAnchor.constraint(equalTo: container.topAnchor, constant: Layout.defaultInset),
                horizontalStack.leftAnchor.constraint(equalTo: container.leftAnchor, constant: Layout.defaultInset),
                horizontalStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -Layout.defaultInset),
                horizontalStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Layout.defaultInset),
                itemDaysLabel.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor, multiplier: 0.3)
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
            .frame(height: 100)
            .padding(.horizontal, 16)
    }
}
#endif
