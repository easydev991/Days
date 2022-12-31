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
        // Test emptyView is presented on first launch
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertTrue(emptyView.exists)

        // Test presenting ItemViewController
        rememberEventButton.tap()
        XCTAssertTrue(itemViewController.exists)

        // Test dismissing ItemViewController
        closeItemVCButton.tap()
        XCTAssertFalse(itemViewController.exists)
    }

    func testSaveItem_and_deleteItem() {
        // Test saving an item
        let testItem = tableView.cells.firstMatch
        makeTestItem(title: "testItem")
        XCTAssertFalse(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertTrue(tableView.cells.staticTexts["testItem"].exists)
        XCTAssertTrue(tableView.cells.staticTexts["today"].exists)

        // Test item deletion
        testItem.swipeLeft()
        tableView.cells.firstMatch.buttons.firstMatch.tap()
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertFalse(testItem.exists, "testItem should be deleted")
        XCTAssertTrue(emptyView.exists)
    }

    func testSortingButtons() {
        // Test sortingButton and plusButton exist
        makeTestItems(count: 2)
        XCTAssertTrue(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertFalse(emptyView.exists)

        // Test sortingOptions exists
        sortingButton.tap()
        XCTAssertTrue(sortByAlert.exists)
    }

    func testDeleteAllData() {
        // Test deleteDataButton is hidden
        settingsTabButton.tap()
        XCTAssertFalse(deleteDataButton.exists, "deleteDataButton should be hidden if there is no data to delete")

        // Test deleteDataButton is visible
        homeTabButton.tap()
        makeTestItems(count: 2)
        settingsTabButton.tap()
        XCTAssertTrue(deleteDataButton.exists, "deleteDataButton should be visible when there is data to delete")

        // Test warningAlert exists
        deleteDataButton.tap()
        XCTAssertTrue(warningAlert.exists)

        // Test deleteDataButton is hidden
        warningAlertYesButton.tap()
        XCTAssertFalse(deleteDataButton.exists, "deleteDataButton should be hidden after data deletion")

        // Test emptyView after data deletion
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

    func makeTestItem(title: String, isListEmpty: Bool = true) {
        isListEmpty ? rememberEventButton.tap() : plusButton.tap()
        itemTitleTextField.typeText(title)
        saveItemButton.tap()
    }
}
