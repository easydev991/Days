import Foundation

protocol MainPresenterProtocol: AnyObject {
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
                    let isListEmpty = items.isEmpty
                    view?.reload(isListEmpty: isListEmpty)
                    view?.set(title: isListEmpty ? nil : Text.Main.viewTitle.text)
                    let state = MainModel.navItemButtonsState(for: items.count)
                    view?.setNavItemButtons(state)
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
        let itemDays = MainModel.textFrom(date: item.date)
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
        let itemsCount = items.count
        interactor?.removeItem(itemForRemoval) { [weak view] error in
            if let error = error {
                view?.showError(error.localizedDescription)
            } else {
                view?.setNavItemButtons(MainModel.navItemButtonsState(for: itemsCount))
                view?.set(title: itemsCount == .zero ? nil : Text.Main.viewTitle.text)
                view?.setEmptyView(hidden: itemsCount != .zero)
                completion?()
            }
        }
    }
}
