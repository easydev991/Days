import XCTest
@testable import Days_2_1

final class MainViewControllerTest: XCTestCase {
    var presenter: MainPresenterMock!
    var interactor: MainInteractorMock!
    var viewController: MainViewController!
    var router: MainRouterMock!

    override func setUpWithError() throws {
        presenter = MainPresenterMock()
        interactor = MainInteractorMock()
        viewController = MainViewController()
        router = MainRouterMock()

        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }

    override func tearDownWithError() throws {
        presenter = nil
        interactor = nil
        viewController = nil
        router = nil
    }

    func testSetItemData() {
        let testItem = Item()
        testItem.title = "Name"
        testItem.date = Date()
        viewController.takeItem(with: testItem.title, and: testItem.date)
        let newItem = presenter.items.first
        XCTAssertNotNil(newItem)
        XCTAssertEqual(testItem.title, newItem?.title)
        XCTAssertEqual(testItem.date, newItem?.date)
    }
}
