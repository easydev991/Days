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
        XCTAssertEqual(_tableView?.isHidden, true)
        XCTAssertNotEqual(_emptyView?.alpha, .zero)
    }

    func testReloadListIsNotEmpty() {
        viewController.reload(isListEmpty: false)
        XCTAssertEqual(_tableView?.isHidden, false)
        XCTAssertNotEqual(_emptyView?.alpha, 1)
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

    func testSetEmptyViewHiddenTrue() {
        viewController.setEmptyView(hidden: true)
        XCTAssertNotEqual(_emptyView?.alpha, 1)
    }

    func testSetEmptyViewHiddenFalse() {
        viewController.setEmptyView(hidden: false)
        XCTAssertNotEqual(_emptyView?.alpha, .zero)
    }

    func testShowError() {
        viewController.showError("")
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

    func testSetNavItemButtons_none() {
        viewController.setNavItemButtons(.none)
        XCTAssertNil(_leftButton)
        XCTAssertNil(_rightButton)
    }

    func testSetNavItemButtons_add() {
        viewController.setNavItemButtons(.add)
        XCTAssertNil(_leftButton)
        XCTAssertNotNil(_rightButton)
    }

    func testSetNavItemButtons_sortAndAdd() {
        viewController.setNavItemButtons(.sortAndAdd)
        XCTAssertNotNil(_leftButton)
        XCTAssertNotNil(_rightButton)
    }
}

private extension MainViewControllerTest {
    var _testItem: Item {
        let item = Item()
        item.title = "Name"
        item.date = Date()
        return item
    }

    var _emptyView: UIView? {
        viewController.view.subviews.first(where: { $0 is EmptyView })
    }

    var _tableView: UIView? {
        viewController.view.subviews.first(where: { $0 is UITableView })
    }

    var _leftButton: UIBarButtonItem? {
        viewController.navigationItem.leftBarButtonItem
    }

    var _rightButton: UIBarButtonItem? {
        viewController.navigationItem.rightBarButtonItem
    }
}
