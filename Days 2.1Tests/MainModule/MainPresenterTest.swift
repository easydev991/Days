import XCTest
@testable import Days_2_1

final class MainPresenterTest: XCTestCase {
    var presenter: MainPresenter!
    var viewController: MainViewControllerMock!
    var interactor: MainInteractorMock!
    var router: MainRouterMock!

    override func setUpWithError() throws {
        presenter = MainPresenter()
        viewController = MainViewControllerMock()
        interactor = MainInteractorMock()
        router = MainRouterMock()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
        interactor = nil
        router = nil
    }

    func testRequestItems() {
        let mockItems = ItemsMock.items
        let initialCount = 0
        presenter.requestItems()
        let finalCount = presenter.itemsCount
        XCTAssertNotEqual(initialCount, finalCount)
        XCTAssertEqual(mockItems.count, finalCount)
    }

    func testSaveItem() {
        let initialCount = 0
        presenter.saveItem(with: "Name", and: Date())
        let finalCount = presenter.itemsCount
        XCTAssertNotEqual(initialCount, finalCount)
    }

    func testRemoveItem() {
        let mockItems = ItemsMock.items
        let randomIndex = ItemsMock.randomIndex
        mockItems.forEach { item in
            presenter.saveItem(
                with: item.title,
                and: item.date
            )
        }
        presenter.removeItem(at: randomIndex) {}
        XCTAssertNotEqual(mockItems.count, presenter.itemsCount)
    }
}
