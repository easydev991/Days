import Foundation

protocol MainPresenterProtocol: AnyObject {
    var dataSource: MainDataSourceService { get }
    var availableSortOptions: [SortBy] { get }
    func addItemTapped()
    func requestItems()
    func sortBy(_ sort: SortBy)
    func saveItem(
        with title: String,
        and date: Date
    )
    func removeItem(
        at index: Int,
        completion: VoidBlock?
    )
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    let dataSource: MainDataSourceService
    private var sortModel = ItemSortModel(.dateDescending)

    init(with dataSource: MainDataSourceService) {
        self.dataSource = dataSource
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadAfterDeletion),
            name: .allDataHasBeedDeleted,
            object: nil
        )
    }
}

extension MainPresenter: MainPresenterProtocol {
    var availableSortOptions: [SortBy] {
        SortBy.allCases.filter { $0 != sortModel.sorting }
    }

    func addItemTapped() {
        router?.openItemViewController()
    }

    func requestItems() {
        interactor?.loadItems(sortedBy: sortModel) { [weak dataSource, weak view] result in
            switch result {
            case .success(let items):
                dataSource?.set(items: items)
                let isListEmpty = items.isEmpty
                view?.reload(isListEmpty: isListEmpty)
                view?.set(title: isListEmpty ? nil : Text.Main.viewTitle.text)
                view?.setNavItemButtons(MainModel.navItemState(for: items.count))
                view?.setEmptyView(hidden: !isListEmpty)
            case .failure(let error):
                view?.showError(error.localizedDescription)
            }
        }
    }

    func sortBy(_ sort: SortBy) {
        sortModel = .init(sort)
        requestItems()
    }

    func saveItem(
        with title: String,
        and date: Date
    ) {
        interactor?.saveItem(
            .init(title: title, date: date)
        ) { [weak self, weak view] error in
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
        let itemForRemoval = dataSource.removeItem(at: index)
        let itemsCount = dataSource.itemsCount
        interactor?.removeItem(itemForRemoval) { [weak view] error in
            if let error = error {
                view?.showError(error.localizedDescription)
            } else {
                view?.set(title: itemsCount == .zero ? nil : Text.Main.viewTitle.text)
                view?.setNavItemButtons(MainModel.navItemState(for: itemsCount))
                view?.setEmptyView(hidden: itemsCount != .zero)
                completion?()
            }
        }
    }
}

private extension MainPresenter {
    @objc func reloadAfterDeletion() {
        dataSource.removeAllData()
        view?.set(title: nil)
        view?.setNavItemButtons(MainModel.navItemState(for: .zero))
        view?.setEmptyView(hidden: false)
        view?.reload(isListEmpty: true)
    }
}
