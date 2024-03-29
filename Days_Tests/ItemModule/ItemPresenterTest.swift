@testable import Days
import XCTest

final class ItemPresenterTest: XCTestCase {
    var presenter: ItemPresenter!
    var viewController: ItemViewControllerMock!
    var router: ItemRouterMock!

    override func setUp() {
        super.setUp()
        presenter = ItemPresenter()
        viewController = ItemViewControllerMock()
        router = ItemRouterMock()
        presenter.view = viewController
        presenter.router = router
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        viewController = nil
        router = nil
    }

    func testViewDidLoad() {
        presenter.viewDidLoad()
        XCTAssertFalse(viewController.saveButtonEnabled)
    }

    func testCheckNameForLetters_nil() {
        presenter.checkNameForLettersIn(text: nil)
        XCTAssertFalse(viewController.saveButtonEnabled)
    }

    func testCheckNameForLetters_space() {
        presenter.checkNameForLettersIn(text: " ")
        XCTAssertFalse(viewController.saveButtonEnabled)
    }

    func testCheckNameForLetters_letter() {
        presenter.checkNameForLettersIn(text: "a")
        XCTAssertTrue(viewController.saveButtonEnabled)
    }

    func testCheckNameForLetters_spaceWithLetter() {
        presenter.checkNameForLettersIn(text: " a")
        XCTAssertTrue(viewController.saveButtonEnabled)
    }

    func testFinishFlow() {
        presenter.finishFlow()
        XCTAssertTrue(router.didDismiss)
    }
}
