import XCTest

final class Days_UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func testEmptyState_and_presentDismissItemVC() {
        // testShowEmptyView on first launch
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertTrue(emptyView.exists)

        // testPresentItemViewController
        rememberEventButton.tap()
        XCTAssertTrue(itemViewController.exists)

        // testDismissItemViewController
        closeItemVCButton.tap()
        XCTAssertFalse(itemViewController.exists)
    }

    func testSaveItem_and_deleteItem() {
        // testSaveItem
        let testItem = tableView.cells.firstMatch
        makeTestItem(title: "testItem")
        XCTAssertFalse(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertTrue(tableView.cells.staticTexts["testItem"].exists)
        XCTAssertTrue(tableView.cells.staticTexts["today"].exists)

        // testDeleteItem
        testItem.swipeLeft()
        tableView.cells.firstMatch.buttons.firstMatch.tap()
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertFalse(testItem.exists, "testItem should be deleted")
        XCTAssertTrue(emptyView.exists)
    }

    func testSortingButtons() {
        // testSortAndPlusButtonsExist
        makeTestItems(count: 2)
        XCTAssertTrue(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertFalse(emptyView.exists)

        // testPresentSortingOptions
        sortingButton.tap()
        XCTAssertTrue(sortByAlert.exists)
    }

    func testDeleteAllData() {
        // testDeleteDataButton is hidden
        settingsTabButton.tap()
        XCTAssertFalse(deleteDataButton.exists, "deleteDataButton should be hidden if there is no data to delete")

        // testDeleteDataButton is visible
        homeTabButton.tap()
        makeTestItems(count: 2)
        settingsTabButton.tap()
        XCTAssertTrue(deleteDataButton.exists, "deleteDataButton should be visible when there is data to delete")

        // testWarningAlert exists
        deleteDataButton.tap()
        XCTAssertTrue(warningAlert.exists)

        // testDeleteDataButton is hidden
        warningAlertYesButton.tap()
        XCTAssertFalse(deleteDataButton.exists, "deleteDataButton should be hidden after data deletion")

        // testShowEmptyView after data deletion
        successAlertCloseButton.tap()
        homeTabButton.tap()
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertTrue(emptyView.exists)
    }
}

private extension Days_UITests {
    var emptyView: XCUIElement { app.otherElements["MainVC_emptyView"] }
    var tableView: XCUIElement { app.tables["MainVC_tableView"] }
    var rememberEventButton: XCUIElement { app.buttons["EmptyView_addNewItemButton"] }
    var itemViewController: XCUIElement { app.otherElements["ItemVC_rootView"] }
    var closeItemVCButton: XCUIElement { app.buttons["ItemVC_cancelButton"]}
    var saveItemButton: XCUIElement { app.buttons["ItemVC_saveButton"] }
    var itemTitleTextField: XCUIElement { app.textFields["ItemVC_itemTitleTextField"] }
    var sortingButton: XCUIElement { app.buttons["MainVC_sortingButton"] }
    var plusButton: XCUIElement { app.buttons["MainVC_addNewItemButton"] }
    var sortByAlert: XCUIElement { app.alerts["Sort by"] }
    var tabbar: XCUIElement { app.tabBars["Tab Bar"] }
    var homeTabButton: XCUIElement { tabbar.buttons["home"] }
    var settingsTabButton: XCUIElement { tabbar.buttons["settings"] }
    var deleteDataButton: XCUIElement { app.buttons["SettingsView_deleteDataButton"] }
    var warningAlert: XCUIElement { app.alerts["Warning!"] }
    var warningAlertYesButton: XCUIElement { warningAlert.buttons["Yes"] }
    var successAlert: XCUIElement { app.alerts["Success"] }
    var successAlertCloseButton: XCUIElement { successAlert.buttons["Close"] }

    func makeTestItems(count: Int) {
        (.zero...count-1).forEach { index in
            makeTestItem(
                title: "Test item \(index)",
                isListEmpty: index == .zero
            )
        }
    }

    func makeTestItem(
        title: String,
        isListEmpty: Bool = true
    ) {
        isListEmpty ? rememberEventButton.tap() : plusButton.tap()
        itemTitleTextField.typeText(title)
        saveItemButton.tap()
    }
}
