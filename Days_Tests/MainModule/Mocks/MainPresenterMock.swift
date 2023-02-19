@testable import Days
import Foundation

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

    func sortBy(_: SortBy) {}

    func addItemTapped() {}

    func updateSortModel(sortBy _: ItemSort, ascending _: Bool) {}

    func requestItems() {
        interactor.loadItems(sortedBy: .init(.dateAscending)) { [weak dataSource] result in
            switch result {
            case let .success(items):
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
