import UIKit

protocol ItemCellInput {
    func setup(with model: ItemCell.Model)
}

final class ItemCell: UITableViewCell {
    static let cellID = "ItemCell"

    // MARK: - UI
    private lazy var itemView: ItemView = {
        let view = ItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

// MARK: - ItemCellInput
extension ItemCell: ItemCellInput {
    func setup(with model: ItemCell.Model) {
        itemView.setup(with: model)
    }
}

// MARK: - Private extension
private extension ItemCell {
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(itemView)
        let itemViewBottomConstraint = itemView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Layout.smallInset
        )
        itemViewBottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate(
            [
                itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.smallInset),
                itemView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Layout.defaultInset),
                itemView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Layout.defaultInset),
                itemViewBottomConstraint
            ]
        )
    }
}
