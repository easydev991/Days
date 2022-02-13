import XCTest
@testable import Days

final class MainInteractorTest: XCTestCase {
    var presenter: MainPresenterMock!
    var itemStorage: ItemStorageMock!
    var interactor: MainInteractor!

    override func setUpWithError() throws {
        presenter = MainPresenterMock()
        itemStorage = ItemStorageMock()
        interactor = MainInteractor(with: itemStorage)

        presenter.interactor = interactor
    }

    override func tearDownWithError() throws {
        presenter = nil
        itemStorage = nil
        interactor = nil
    }

    func testLoadItems_success() {
        let mockItems = ItemsMock.items
        interactor.loadItems(
            sortedBy: .init(.dateAscending),
            completion: { result in
                switch result {
                case .success(let items):
                    XCTAssertEqual(mockItems.count, items.count)
                case .failure:
                    XCTFail("Items must be loaded")
                }
            }
        )
    }

    func testSaveItem() {
        presenter.saveItem(with: "test", and: Date())
        XCTAssertEqual(1, presenter.dataSource.itemsCount)
    }

    func testRemoveItem() {
        presenter.requestItems()
        let randomIndex = ItemsMock.randomIndex
        presenter.removeItem(at: randomIndex) {}
        XCTAssertEqual(9, presenter.dataSource.itemsCount)
    }
}
