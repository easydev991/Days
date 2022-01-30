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

    func testSetTitle() {
        let testTitle = "testTitle"
        viewController.set(title: testTitle)
        XCTAssertEqual(testTitle, viewController.title)
    }

    func testTakeItem() {
        let testItem = _testItem
        viewController.takeItem(with: testItem.title, and: testItem.date)
        let newItem = presenter.items.first
        XCTAssertNotNil(newItem)
        XCTAssertEqual(testItem.title, newItem?.title)
        XCTAssertEqual(testItem.date, newItem?.date)
    }

    func testSetNavItemButtons_none() {
        viewController.setNavItemButtons(.none)
        XCTAssertNil(sortButton)
        XCTAssertNil(plusButton)
    }

    func testSetNavItemButtons_add() {
        viewController.setNavItemButtons(.add)
        XCTAssertNil(sortButton)
        XCTAssertNotNil(plusButton)
    }

    func testSetNavItemButtons_sortAndAdd() {
        viewController.setNavItemButtons(.sortAndAdd)
        XCTAssertNotNil(sortButton)
        XCTAssertNotNil(plusButton)
    }
}

private extension MainViewControllerTest {
    var _testItem: Item {
        Item(title: "Title", date: Date())
    }

    var sortButton: UIBarButtonItem? {
        viewController.navigationItem.leftBarButtonItem
    }

    var plusButton: UIBarButtonItem? {
        viewController.navigationItem.rightBarButtonItem
    }
}
