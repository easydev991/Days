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

    func testTitle() {
        let title = presenter.title
        XCTAssertFalse(title.isEmpty)
    }

    func testRequestItems() {
        let mockItems = ItemsMock.items
        let initialCount = presenter.items.count
        presenter.requestItems()
        let finalCount = presenter.items.count
        XCTAssertNotEqual(initialCount, finalCount)
        XCTAssertEqual(mockItems.count, finalCount)
    }

    func testSaveItem() {
        let initialCount = presenter.items.count
        presenter.saveItem(name: "Name", date: Date())
        let finalCount = presenter.items.count
        XCTAssertNotEqual(initialCount, finalCount)
    }

    func testRemoveItem() {
        let mockItems = ItemsMock.items
        let randomIndex = ItemsMock.randomIndex
        mockItems.forEach { item in
            presenter.saveItem(
                name: item.itemName,
                date: item.date
            )
        }
        presenter.removeItem(at: randomIndex) {}
        XCTAssertNotEqual(mockItems.count, presenter.items.count)
    }

    func testReloadView() {
        presenter.reloadView()
        XCTAssertEqual(true, viewController.reloadComplete)
    }
}
