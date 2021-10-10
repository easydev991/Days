//
//  MainInteractorTest.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import XCTest
@testable import Days_2_1

final class MainInteractorTest: XCTestCase {
    var presenter: MainPresenterMock!
    var itemStorage: ItemStorageMock!
    var interactor: MainInteractor!

    override func setUpWithError() throws {
        presenter = MainPresenterMock()
        itemStorage = ItemStorageMock()
        interactor = MainInteractor(itemStorage: itemStorage)

        presenter.interactor = interactor
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        presenter = nil
        itemStorage = nil
        interactor = nil
    }

    func testLoadItems() {
        let mockItems = ItemsMock.items
        let items = interactor.loadItems(sortedBy: .itemName, ascending: true)
        XCTAssertEqual(items.count, mockItems.count)
    }

    func testSaveItem() {
        presenter.saveItem(name: "test", date: Date())
        XCTAssertEqual(presenter.items.count, 1)
    }

    func testRemoveItem() {
        presenter.requestItems()
        let randomIndex = ItemsMock.randomIndex
        presenter.removeItem(at: randomIndex) {}
        XCTAssertEqual(presenter.items.count, 9)
    }
}
