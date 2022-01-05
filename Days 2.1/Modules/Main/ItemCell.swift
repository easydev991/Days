import UIKit

protocol ItemCellInput {
    func setup(with model: ItemCell.Model)
}

final class ItemCell: UITableViewCell {
    static let cellID = "ItemCell"

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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension ItemCell {
    struct Model {
        let itemName: String
        let itemDays: String
    }
}

// MARK: - TableViewCellInput
extension ItemCell: ItemCellInput {
    func setup(with model: ItemCell.Model) {
        itemNameLabel.text = model.itemName
        itemDaysLabel.text = model.itemDays
        horizontalStack.layoutIfNeeded()
    }
}

// MARK: - Private extension
private extension ItemCell {
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        container.addSubview(horizontalStack)
        contentView.addSubview(container)
        let containerBottomConstraint = container.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Layout.smallInset
        )
        containerBottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate(
            [
                container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.smallInset),
                container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Layout.defaultInset),
                container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Layout.defaultInset),
                containerBottomConstraint,
                horizontalStack.topAnchor.constraint(equalTo: container.topAnchor, constant: Layout.defaultInset),
                horizontalStack.leftAnchor.constraint(equalTo: container.leftAnchor, constant: Layout.defaultInset),
                horizontalStack.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -Layout.defaultInset),
                horizontalStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Layout.defaultInset),
                itemDaysLabel.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor, multiplier: 0.3)
            ]
        )
    }
}
