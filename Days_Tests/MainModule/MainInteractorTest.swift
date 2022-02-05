import XCTest
@testable import Days

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

    func testLoadItems_success() {
        let mockItems = ItemsMock.items
        interactor.loadItems(
            sortedBy: .init(.dateAscending),
            completion: { result in
                switch result {
                case .success(let items):
                    XCTAssertEqual(items.count, mockItems.count)
                case .failure:
                    XCTFail("Items must be loaded")
                }
            }
        )
    }

    func testSaveItem() {
        presenter.saveItem(with: "test", and: Date())
        XCTAssertEqual(presenter.itemsCount, 1)
    }

    func testRemoveItem() {
        presenter.requestItems()
        let randomIndex = ItemsMock.randomIndex
        presenter.removeItem(at: randomIndex) {}
        XCTAssertEqual(presenter.itemsCount, 9)
    }
}
