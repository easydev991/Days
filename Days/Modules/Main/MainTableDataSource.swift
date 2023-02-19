import UIKit

protocol MainDataSourceService: UITableViewDataSource {
    var itemsCount: Int { get }
    func set(items: [Item])
    func removeItem(at index: Int) -> Item?
    func removeAllData()
}

final class MainDataSource: NSObject, MainDataSourceService {
    private var items = [Item]()

    var itemsCount: Int {
        items.count
    }

    func set(items: [Item]) {
        self.items = items
    }

    func removeItem(at index: Int) -> Item? {
        items.isEmpty ? nil : items.remove(at: index)
    }

    func removeAllData() {
        items = []
    }

    func tableView(
        _: UITableView,
        numberOfRowsInSection _: Int
    ) -> Int {
        itemsCount
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCell.cellID,
            for: indexPath
        ) as? ItemCell {
            let item = items[indexPath.row]
            let itemDays = MainModel.textFrom(date: item.date)
            let model = ItemCell.Model(
                title: item.title,
                daysText: itemDays
            )
            cell.setup(with: model)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
