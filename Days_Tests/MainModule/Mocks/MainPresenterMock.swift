import Foundation
@testable import Days

final class MainPresenterMock {
    var viewController: MainViewControllerProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    let dataSource: MainDataSourceService = MainDataSource()
}

extension MainPresenterMock: MainPresenterProtocol {
    var title: String { "Title" }

    var availableSortOptions: [SortBy] { SortBy.allCases }

    func removeItem(at index: Int, completion: VoidBlock?) {
        let itemForRemoval = dataSource.removeItem(at: index)
        interactor.removeItem(itemForRemoval) { _ in completion?() }
    }

    func sortBy(_ sort: SortBy) {}

    func addItemTapped() {}

    func updateSortModel(sortBy: ItemSort, ascending: Bool) {}

    func requestItems() {
        interactor.loadItems(sortedBy: .init(.dateAscending)) { [weak dataSource] result in
            switch result {
            case .success(let items):
                dataSource?.set(items: items)
            case .failure:
                break
            }
        }
    }

    func saveItem(with name: String, and date: Date) {
        let testItem = Item(title: name, date: date)
        interactor.saveItem(testItem) { [weak dataSource] _ in
            dataSource?.set(items: [testItem])
        }
    }
}
