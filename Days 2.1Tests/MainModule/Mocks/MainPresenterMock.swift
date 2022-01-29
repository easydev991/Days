import Foundation
@testable import Days_2_1

final class MainPresenterMock {
    var error: Error? = nil
    var viewController: MainViewControllerProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    var items = [Item]()
}

extension MainPresenterMock: MainPresenterProtocol {
    var title: String { "Title" }

    var itemsCount: Int {
        interactor.itemsCount
    }

    var availableSortOptions: [SortBy] {
        SortBy.allCases
    }

    func removeItem(at index: Int, completion: VoidBlock?) {
        let itemForRemoval = items.remove(at: index)
        interactor.removeItem(itemForRemoval) { _ in
            completion?()
        }
    }

    func sortBy(_ sort: SortBy) {}

    func addItemTapped() {}

    func updateSortModel(sortBy: ItemSort, ascending: Bool) {}

    func requestItems() {
        interactor.loadItems(
            sortedBy: .init(.dateAscending),
            completion: { [weak self] result in
                switch result {
                case .success(let items):
                    self?.items = items
                case .failure(let error):
                    self?.error = error
                }
            }
        )
    }

    func setup(cell: ItemCellInput, at index: Int) {}

    func saveItem(with name: String, and date: Date) {
        let testItem = Item()
        testItem.title = name
        testItem.date = date
        interactor.saveItem(
            testItem,
            completion: { [weak self] _ in
                self?.items.append(testItem)
            }
        )
    }
}
