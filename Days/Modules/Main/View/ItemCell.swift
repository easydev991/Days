import UIKit

protocol ItemCellInput {
    func setup(with model: ItemCell.Model)
}

final class ItemCell: UITableViewCell {
    static let cellID = "ItemCell"

    private let itemView: ItemView = {
        let view = ItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        let title: String
        let daysText: String
    }
}

extension ItemCell: ItemCellInput {
    func setup(with model: ItemCell.Model) {
        itemView.set(title: model.title, daysText: model.daysText)
    }
}

private extension ItemCell {
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(itemView)
        let itemViewBottomConstraint = itemView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Layout.Insets.small
        )
        itemViewBottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate(
            [
                itemView.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Layout.Insets.small
                ),
                itemView.leftAnchor.constraint(
                    equalTo: contentView.leftAnchor,
                    constant: Layout.Insets.standard
                ),
                itemView.rightAnchor.constraint(
                    equalTo: contentView.rightAnchor,
                    constant: -Layout.Insets.standard
                ),
                itemViewBottomConstraint
            ]
        )
    }
}
