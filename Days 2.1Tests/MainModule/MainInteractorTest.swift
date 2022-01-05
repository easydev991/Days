import XCTest
@testable import Days_2_1

final class MainInteractorTest: XCTestCase {
    var presenter: MainPresenterMock!
    var itemStorage: ItemStorageMock!
    var interactor: MainInteractor!

    override func setUpWithError() throws {
        presenter = MainPresenterMock()
        itemStorage = ItemStorageMock()
        interactor = MainInteractor(itemStorage: itemStorage)

        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        presenter = nil
        itemStorage = nil
        interactor = nil
    }

    func testLoadItems() {
        let mockItems = ItemsMock.items
        let items = interactor.loadItems(sortedBy: .init(sortBy: .itemName, ascending: false))
        XCTAssertEqual(items.count, mockItems.count)
    }

    func testSaveItem() {
        presenter.saveItem(name: "test", date: Date())
        XCTAssertEqual(presenter.items.count, 1)
    }

    func testRemoveItem() {
        presenter.requestItems()
        let randomIndex = ItemsMock.randomIndex
        presenter.removeItem(at: randomIndex) {}
        XCTAssertEqual(presenter.items.count, 9)
    }
}
