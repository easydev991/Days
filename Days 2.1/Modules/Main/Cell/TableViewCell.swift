import UIKit

protocol TableViewCellInput {
    func setup(with model: TableViewCell.Model)
}

final class TableViewCell: UITableViewCell {
    static let cellID = "Cell"

    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var itemNameLabel: UILabel!
    @IBOutlet private weak var itemDaysLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }
}

extension TableViewCell {
    struct Model {
        let itemName: String
        let itemDays: String
    }
}

extension TableViewCell: TableViewCellInput {
    func setup(with model: TableViewCell.Model) {
        itemNameLabel.text = model.itemName
        itemDaysLabel.text = model.itemDays
    }
}

private extension TableViewCell {
    func setupUI() {
        backgroundColor = .clear
        container.layer.cornerRadius = 8
        [itemNameLabel, itemDaysLabel].forEach {
            $0?.numberOfLines = .zero
        }
        container.backgroundColor = .systemYellow
    }
}
