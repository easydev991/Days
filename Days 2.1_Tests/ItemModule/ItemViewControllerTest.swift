import XCTest
@testable import Days_2_1

final class ItemViewControllerTest: XCTestCase {
    var presenter: ItemPresenterMock!
    var viewController: ItemViewController!
    var router: ItemRouterMock!

    override func setUpWithError() throws {
        presenter = ItemPresenterMock()
        viewController = ItemViewController()
        router = ItemRouterMock()

        presenter.viewController = viewController
        presenter.router = router
        viewController.presenter = presenter
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
        router = nil
    }

    func testSaveAction_textIsNil() {
        viewController.saveAction()
        XCTAssertFalse(router.didDismiss, "cannot perform save action when text is nil")
    }
}
