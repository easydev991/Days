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

    func testReloadListIsEmpty() {
        viewController.reload(isListEmpty: true)
        let emptyView = emptyView
        let tableView = tableView
        XCTAssertEqual(tableView?.isHidden, true)
        XCTAssertNotEqual(emptyView?.alpha, .zero)
    }

    func testReloadListIsNotEmpty() {
        viewController.reload(isListEmpty: false)
        let emptyView = emptyView
        let tableView = tableView
        XCTAssertEqual(tableView?.isHidden, false)
        XCTAssertNotEqual(emptyView?.alpha, 1)
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
        XCTAssertNotEqual(emptyView?.alpha, 1)
    }

    func testSetEmptyViewHiddenFalse() {
        viewController.setEmptyView(hidden: false)
        let emptyView = emptyView
        XCTAssertNotEqual(emptyView?.alpha, .zero)
    }

    func testShowError() {
        let message = "test error message"
        viewController.showError(message)
        XCTAssertNotNil(viewController.navigationController?.visibleViewController is UIAlertController)
    }

    func testAddButtonTapped() {
        viewController.buttonTapped()
        XCTAssertNotNil(viewController.navigationController?.visibleViewController is ItemViewController)
    }

    func testPresentItemViewController() {
        let vc = ItemViewController()
        viewController.present(vc)
        XCTAssertNotNil(viewController.navigationController?.visibleViewController is ItemViewController)
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

    var tableView: UIView? {
        viewController.view.subviews.first(where: { $0 is UITableView })
    }
}
