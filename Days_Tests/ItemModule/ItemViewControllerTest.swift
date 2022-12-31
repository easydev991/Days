import XCTest
@testable import Days

final class ItemViewControllerTest: XCTestCase {
    var presenter: ItemPresenterMock!
    var viewController: ItemViewController!
    var router: ItemRouterMock!

    override func setUp() {
        super.setUp()
        presenter = ItemPresenterMock()
        viewController = ItemViewController()
        router = ItemRouterMock()
        presenter.viewController = viewController
        presenter.router = router
        viewController.presenter = presenter
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        viewController = nil
        router = nil
    }

    func testSaveAction_textIsNil() {
        viewController.saveAction()
        XCTAssertFalse(router.didDismiss, "cannot perform save action when text is nil")
    }
}
