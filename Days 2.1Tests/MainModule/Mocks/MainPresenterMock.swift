import UIKit
@testable import Days_2_1

final class MainPresenterMock {
    var viewController: MainViewControllerProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    var items = [Item]()
}

extension MainPresenterMock: MainPresenterProtocol {
    func addItemTapped() {}

    func updateSortModel(sortBy: ItemSort, ascending: Bool) {}

    var title: String { "Title" }

    func requestItems() {
        items = interactor.loadItems(sortedBy: .init(sortBy: .itemName, ascending: false))
    }

    func setup(cell: ItemCellInput, at index: Int) {}

    func saveItem(name: String, date: Date) {
        let testItem = Item()
        testItem.itemName = name
        testItem.date = date
        interactor.saveItem(
            testItem,
            completion: { _ in
                items.append(testItem)
            }
        )
    }

    func removeItem(at index: Int, completion: () -> Void) {
        let itemForRemoval = items.remove(at: index)
        interactor.removeItem(itemForRemoval) { _ in
            completion()
        }
    }

    func reloadView() {}
}
