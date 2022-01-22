import Foundation

protocol MainPresenterProtocol: AnyObject {
    var title: String { get }
    var items: [Item] { get }
    func addItemTapped()
    func requestItems()
    func sortBy(_ sort: SortBy)
    func setup(cell: ItemCellInput, at index: Int)
    func saveItem(name: String, date: Date)
    func removeItem(at index: Int, completion: VoidBlock)
    func reloadView()
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    var items = [Item]()
    private var sortModel = ItemSortModel(.dateDescending)
}

extension MainPresenter: MainPresenterProtocol {
    var title: String {
        Text.Main.viewTitle.text
    }

    func addItemTapped() {
        router?.openItemViewController()
    }

    func requestItems() {
        if let receivedItems = interactor?.loadItems(sortedBy: sortModel) {
            items = receivedItems
            reloadView()
        }
    }

    func sortBy(_ sort: SortBy) {
        sortModel = .init(sort)
        requestItems()
    }

    func setup(
        cell: ItemCellInput,
        at index: Int
    ) {
        let item = items[index]
        let itemDays = dateToTextDays(item: item)
        let model = ItemCell.Model(
            itemName: item.itemName,
            itemDays: itemDays
        )
        cell.setup(with: model)
    }

    func saveItem(
        name: String,
        date: Date
    ) {
        let item = Item()
        item.itemName = name
        item.date = date
        interactor?.saveItem(item) { error in
            if let error = error {
                print("Error saving item at storage: \(error.localizedDescription)")
            } else {
                items.append(item)
                items.sort { $0.date > $1.date }
                reloadView()
            }
        }
    }

    func removeItem(
        at index: Int,
        completion: VoidBlock
    ) {
        let itemForRemoval = items.remove(at: index)
        interactor?.removeItem(itemForRemoval) { error in
            if let error = error {
                print("Error removing item at storage: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }

    func reloadView() {
        view?.reload()
    }
}

private extension MainPresenter {
    func dateToTextDays(item: Item) -> String {
        let today = Date()
        let calendar = Calendar.current
        let daysCount = calendar.numberOfDaysBetween(item.date, and: today)
        return daysCount != .zero
        ? Text.Main.daysPast(daysCount).text
        : Text.Main.today.text
    }
}
