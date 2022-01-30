import XCTest

final class Days_2_1_UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func testShowEmptyView() {
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertTrue(emptyView.exists)
    }

    func testPresentItemViewController() {
        rememberEventButton.tap()
        XCTAssertTrue(itemViewController.exists)
    }

    func testDismissItemViewController() {
        rememberEventButton.tap()
        closeItemVCButton.tap()
        XCTAssertFalse(itemViewController.exists)
    }

    func testSaveButtonEnabled_textIsNil() {
        rememberEventButton.tap()
        XCTAssertFalse(saveItemButton.isEnabled)
    }

    func testSaveButtonEnabled_textIsSpace() {
        rememberEventButton.tap()
        itemTitleTextField.typeText(" ")
        XCTAssertFalse(saveItemButton.isEnabled)
    }

    func testSaveButtonEnabled_textContainsLetter() {
        rememberEventButton.tap()
        itemTitleTextField.typeText("A")
        XCTAssertTrue(saveItemButton.isEnabled)
    }

    func testSaveButtonEnabled_textContainsSpaceAndLetter() {
        rememberEventButton.tap()
        itemTitleTextField.typeText(" a")
        XCTAssertTrue(saveItemButton.isEnabled)
    }

    func testSaveItem() {
        makeTestItem(title: "testSaveItem")
        XCTAssertFalse(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertTrue(tableView.cells.staticTexts["testSaveItem"].exists)
        XCTAssertTrue(tableView.cells.staticTexts["today"].exists)
    }

    func testDeleteItem() {
        let itemToDelete = tableView.cells.firstMatch
        makeTestItem(title: "testDeleteItem")
        itemToDelete.swipeLeft()
        tableView.cells.firstMatch.buttons.firstMatch.tap()
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertFalse(itemToDelete.exists)
        XCTAssertTrue(emptyView.exists)
    }

    func testSortButtonExists() {
        makeTestItems(count: 2)
        XCTAssertTrue(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertFalse(emptyView.exists)
    }

    func testPresentSortingOptions() {
        makeTestItems(count: 2)
        sortingButton.tap()
        XCTAssertTrue(app.alerts.firstMatch.exists)
    }

    func testDismissSortingOptions() {
        makeTestItems(count: 2)
        sortingButton.tap()
        closeAlertButton.tap()
        XCTAssertFalse(app.alerts.firstMatch.exists)
    }
}

private extension Days_2_1_UITests {
    var emptyView: XCUIElement { app.otherElements["MainVC_emptyView"] }
    var tableView: XCUIElement { app.tables["MainVC_tableView"] }
    var rememberEventButton: XCUIElement { app.buttons["EmptyView_addNewItemButton"] }
    var itemViewController: XCUIElement { app.otherElements["ItemVC_rootView"] }
    var closeItemVCButton: XCUIElement { app.buttons["ItemVC_cancelButton"]}
    var saveItemButton: XCUIElement { app.buttons["ItemVC_saveButton"] }
    var itemTitleTextField: XCUIElement { app.textFields["ItemVC_itemTitleTextField"] }
    var sortingButton: XCUIElement { app.buttons["MainVC_sortingButton"] }
    var plusButton: XCUIElement { app.buttons["MainVC_addNewItemButton"] }
    var closeAlertButton: XCUIElement { app.alerts.buttons["Close"] }

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
