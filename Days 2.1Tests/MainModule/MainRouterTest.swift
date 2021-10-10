//
//  MainRouterTest.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import XCTest
@testable import Days_2_1

final class MainRouterTest: XCTestCase {
    var presenter: MainPresenterMock!
    var viewController: MainViewControllerMock!
    var interactor: MainInteractorMock!
    var router: MainRouter!

    override func setUpWithError() throws {
        presenter = MainPresenterMock()
        viewController = MainViewControllerMock()
        interactor = MainInteractorMock()
        router = MainRouter()

        router.viewController = viewController
    }

    override func tearDownWithError() throws {
        presenter = nil
        viewController = nil
        interactor = nil
        router = nil
    }

    func testPrepareForSegue() {
        let testSegue = viewController.testSegue
        let destination = testSegue.destination as? ItemViewController
        router.prepare(for: testSegue, sender: nil)
        XCTAssertNotNil(destination?.delegate)
    }
}
