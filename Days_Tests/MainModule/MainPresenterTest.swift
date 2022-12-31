import XCTest
@testable import Days

final class MainPresenterTest: XCTestCase {
    var presenter: MainPresenter!
    var viewController: MainViewControllerMock!
    var interactor: MainInteractorMock!
    var router: MainRouterMock!
    
    override func setUp() {
        super.setUp()
        presenter = MainPresenter(with: MainDataSource())
        viewController = MainViewControllerMock()
        interactor = MainInteractorMock()
        router = MainRouterMock()
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        viewController = nil
        interactor = nil
        router = nil
    }
    
    func testTypesOfSortCount() {
        let allSortOptions = SortBy.allCases.count
        let availableSortOptions = presenter.availableSortOptions.count
        XCTAssertNotEqual(allSortOptions, availableSortOptions)
    }
    
    func testRequestItems() {
        presenter.requestItems()
        XCTAssertNotEqual(.zero, presenter.dataSource.itemsCount)
        XCTAssertEqual(ItemsMock.items.count, presenter.dataSource.itemsCount)
    }
    
    func testRemoveItem() {
        ItemsMock.items.forEach {
            presenter.saveItem(with: $0.title, and: $0.date)
        }
        presenter.removeItem(at: ItemsMock.randomIndex, completion: nil)
        XCTAssertNotEqual(ItemsMock.items.count, presenter.dataSource.itemsCount)
        XCTAssertEqual(9, presenter.dataSource.itemsCount)
    }
}
