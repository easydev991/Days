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
        let testItem = testItem
        viewController.takeItem(with: testItem.title, and: testItem.date)
        let newItem = presenter.items.first
        XCTAssertNotNil(newItem)
        XCTAssertEqual(testItem.title, newItem?.title)
        XCTAssertEqual(testItem.date, newItem?.date)
    }

    func testSetEmptyViewHiddenTrue() {
        viewController.setEmptyView(hidden: true)
        let emptyView = emptyView
        XCTAssertTrue(emptyView?.alpha == .zero)
    }

    func testSetEmptyViewHiddenFalse() {
        viewController.setEmptyView(hidden: false)
        let emptyView = emptyView
        XCTAssertNotEqual(emptyView?.alpha, .zero)
    }
}

private extension MainViewControllerTest {
    var testItem: Item {
        let item = Item()
        item.title = "Name"
        item.date = Date()
        return item
    }

    var emptyView: UIView? {
        viewController.view.subviews.first(where: { $0 is EmptyView })
    }
}
