@testable import Days
import XCTest

final class MainInteractorTest: XCTestCase {
    var presenter: MainPresenterMock!
    var itemStorage: ItemStorageMock!
    var interactor: MainInteractor!

    override func setUp() {
        super.setUp()
        presenter = MainPresenterMock()
        itemStorage = ItemStorageMock()
        interactor = MainInteractor(with: itemStorage)
        presenter.interactor = interactor
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        itemStorage = nil
        interactor = nil
    }

    func testLoadItems_success() {
        let mockItems = ItemsMock.items
        interactor.loadItems(sortedBy: .init(.dateAscending)) { result in
            switch result {
            case let .success(items):
                XCTAssertNotEqual(0, items.count)
                XCTAssertEqual(mockItems.count, items.count)
            case .failure:
                XCTFail("Items must be loaded")
            }
        }
    }

    func testSaveItem() {
        presenter.saveItem(with: "test", and: .init())
        XCTAssertEqual(1, presenter.dataSource.itemsCount)
    }

    func testRemoveItem() {
        presenter.requestItems()
        let randomIndex = ItemsMock.randomIndex
        presenter.removeItem(at: randomIndex) {}
        XCTAssertEqual(9, presenter.dataSource.itemsCount)
    }
}
