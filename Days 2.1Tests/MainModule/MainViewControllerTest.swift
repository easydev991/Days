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

    func testPrepareForSegue() {
        let testSegue = MainViewControllerMock().testSegue
        viewController.prepare(for: testSegue, sender: nil)
        XCTAssertEqual(true, router.prepared)
    }

    func testSetItemData() {
        let name = "Name"
        let date = Date()
        viewController.setItemData(itemName: name, itemDate: date)
        let newItem = presenter.items.first
        XCTAssertNotNil(newItem)
    }
}
