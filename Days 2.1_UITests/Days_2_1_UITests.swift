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
        let itemVC = app.otherElements["ItemVC_rootView"]
        rememberEventButton.tap()
        XCTAssertTrue(itemVC.exists)
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
        makeTestItem(title: "Test item")
        XCTAssertFalse(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertTrue(tableView.cells.firstMatch.exists)
    }

    func testDeleteItem() {
        let itemToDelete = tableView.cells.firstMatch
        makeTestItem(title: "Test item")
        itemToDelete.swipeLeft()
        tableView.cells.firstMatch.buttons.firstMatch.tap()
        XCTAssertFalse(sortingButton.exists)
        XCTAssertFalse(plusButton.exists)
        XCTAssertFalse(itemToDelete.exists)
        XCTAssertTrue(emptyView.exists)
    }

    func testSortButtonExists() {
        (0...1).forEach { index in
            makeTestItem(
                title: "Test item \(index)",
                isListEmpty: index == .zero
            )
        }
        XCTAssertTrue(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertFalse(emptyView.exists)
    }
}

private extension Days_2_1_UITests {
    var emptyView: XCUIElement { app.otherElements["MainVC_emptyView"] }
    var tableView: XCUIElement { app.tables["MainVC_tableView"] }
    var rememberEventButton: XCUIElement { app.buttons["EmptyView_addNewItemButton"] }
    var saveItemButton: XCUIElement { app.buttons["ItemVC_saveButton"] }
    var itemTitleTextField: XCUIElement { app.textFields["ItemVC_itemTitleTextField"] }
    var itemDatePicker: XCUIElement { app.datePickers["ItemVC_itemDatePicker"]}
    var sortingButton: XCUIElement { app.buttons["MainVC_sortingButton"] }
    var plusButton: XCUIElement { app.buttons["MainVC_addNewItemButton"] }

    func makeTestItem(
        title: String,
        isListEmpty: Bool = true
    ) {
        let rememberEventButton = rememberEventButton
        let addNewItemButton = plusButton
        let saveButton = saveItemButton
        let textField = itemTitleTextField
        isListEmpty ? rememberEventButton.tap() : addNewItemButton.tap()
        textField.typeText(title)
        saveButton.tap()
    }
}
