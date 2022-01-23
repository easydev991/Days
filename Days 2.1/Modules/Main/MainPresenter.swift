import Foundation

protocol MainPresenterProtocol: AnyObject {
    var title: String { get }
    var itemsCount: Int { get }
    var typesOfSort: [SortBy] { get }
    func addItemTapped()
    func requestItems()
    func sortBy(_ sort: SortBy)
    func setup(cell: ItemCellInput, at index: Int)
    func saveItem(with name: String, and date: Date)
    func removeItem(at index: Int, completion: VoidBlock?)
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    private var items = [Item]()
    private var sortModel = ItemSortModel(.dateDescending)
}

extension MainPresenter: MainPresenterProtocol {
    var title: String {
        Text.Main.viewTitle.text
    }

    var itemsCount: Int {
        interactor?.itemsCount ?? .zero
    }

    var typesOfSort: [SortBy] {
        SortBy.allCases.filter { $0 != sortModel.sorting }
    }

    func addItemTapped() {
        router?.openItemViewController()
    }

    func requestItems() {
        interactor?.loadItems(
            sortedBy: sortModel,
            completion: { [weak self, weak view] result in
                switch result {
                case .success(let items):
                    self?.items = items
                    view?.reload(isListEmpty: items.isEmpty)
                case .failure(let error):
                    view?.showError(error.localizedDescription)
                }
            }
        )
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
        let itemDays = textFrom(date: item.date)
        let model = ItemCell.Model(
            itemName: item.title,
            itemDays: itemDays
        )
        cell.setup(with: model)
    }

    func saveItem(
        with name: String,
        and date: Date
    ) {
        let item = Item()
        item.title = name
        item.date = date
        interactor?.saveItem(item) { [weak self, weak view] error in
            if let error = error {
                view?.showError(error.localizedDescription)
            } else {
                self?.requestItems()
            }
        }
    }

    func removeItem(
        at index: Int,
        completion: VoidBlock?
    ) {
        let itemForRemoval = items.remove(at: index)
        interactor?.removeItem(itemForRemoval) { [weak self, weak view] error in
            if let error = error {
                view?.showError(error.localizedDescription)
            } else {
                view?.setEmptyView(hidden: self?.itemsCount != .zero)
                completion?()
            }
        }
    }
}

private extension MainPresenter {
    func textFrom(date: Date) -> String {
        let today = Date()
        let calendar = Calendar.current
        let daysCount = calendar.numberOfDaysBetween(date, and: today)
        return daysCount != .zero
        ? Text.Main.daysPast(daysCount).text
        : Text.Main.today.text
    }
}
