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

// MARK: - SwiftUI Preview
#if DEBUG
import SwiftUI

struct ItemCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> ItemCell {
        let view = ItemCell()
        let itemData = ItemCell.Model(
            itemName: "Made my first app for iOS device",
            itemDays: "999 days"
        )
        view.setup(with: itemData)
        return view
    }

    func updateUIView(_ uiView: ItemCell, context: Context) {}
}

struct ItemCellPreview: PreviewProvider {
    static var previews: some View {
        ItemCellRepresentable()
            .frame(height: 100)
    }
}
#endif
