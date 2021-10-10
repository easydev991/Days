//
//  MainPresenterTest.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import XCTest
@testable import Days_2_1

final class MainPresenterTest: XCTestCase {
    var presenter: MainPresenter!
    var viewController: MainViewControllerMock!
    var interactor: MainInteractorMock!
    var router: MainRouterMock!

    override func setUpWithError() throws {
        presenter = MainPresenter()
        viewController = MainViewControllerMock()
        interactor = MainInteractorMock()
        router = MainRouterMock()

        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
        interactor = nil
        router = nil
    }

    func testTitle() {
        let title = presenter.title
        XCTAssertFalse(title.isEmpty)
    }

    func testPrepare() {
        let segue = viewController.testSegue
        presenter.prepare(for: segue, sender: nil)
        XCTAssertEqual(true, router.prepared)
    }

    func testRequestItems() {
        let mockItems = ItemsMock.makeItems()
        let initialCount = presenter.items.count
        presenter.requestItems()
        let finalCount = presenter.items.count
        XCTAssertNotEqual(initialCount, finalCount)
        XCTAssertEqual(mockItems.count, finalCount)
    }

    func testSaveItem() {
        let initialCount = presenter.items.count
        presenter.saveItem(name: "Name", date: Date())
        let finalCount = presenter.items.count
        XCTAssertNotEqual(initialCount, finalCount)
    }

    func testRemoveItem() {
        let mockItems = ItemsMock.makeItems()
        let initialCount = mockItems.count
        let firstIndex = Int.zero
        let lastIndex = initialCount - 1
        let randomIndex = Int.random(in: firstIndex...lastIndex)
        mockItems.forEach { item in
            presenter.saveItem(name: item.itemName, date: item.date)
        }
        presenter.removeItem(at: randomIndex) {}
        let finalCount = presenter.items.count
        XCTAssertNotEqual(initialCount, finalCount)
    }

    func testReloadView() {
        presenter.reloadView()
        XCTAssertEqual(true, viewController.reloadComplete)
    }
}
