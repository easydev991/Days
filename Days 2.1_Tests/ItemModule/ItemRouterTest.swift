import XCTest
@testable import Days_2_1

final class ItemRouterTest: XCTestCase {
    var presenter: ItemPresenterMock!
    var viewController: ItemViewControllerMock!
    var router: ItemRouter!

    override func setUpWithError() throws {
        presenter = ItemPresenterMock()
        viewController = ItemViewControllerMock()
        router = ItemRouter()

        router.viewController = viewController
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
        router = nil
    }

    func testDismissViewController() {
        router.dismissViewController()
        XCTAssertTrue(viewController.isDismissed)
    }
}
