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
        let rememberEventButton = addNewItemButton
        let itemVC = app.otherElements["ItemVC_rootView"]
        rememberEventButton.tap()
        XCTAssertTrue(itemVC.exists)
    }

    func testSaveButtonEnabled_textIsNil() {
        let rememberEventButton = addNewItemButton
        let saveButton = saveItemButton
        rememberEventButton.tap()
        XCTAssertFalse(saveButton.isEnabled)
    }

    func testSaveButtonEnabled_textIsSpace() {
        let rememberEventButton = addNewItemButton
        let saveButton = saveItemButton
        let textField = itemTitleTextField
        rememberEventButton.tap()
        textField.typeText(" ")
        XCTAssertFalse(saveButton.isEnabled)
    }

    func testSaveButtonEnabled_textContainsLetter() {
        let rememberEventButton = addNewItemButton
        let saveButton = saveItemButton
        let textField = itemTitleTextField
        rememberEventButton.tap()
        textField.typeText("A")
        XCTAssertTrue(saveButton.isEnabled)
    }

    func testSaveButtonEnabled_textContainsSpaceAndLetter() {
        let rememberEventButton = addNewItemButton
        let saveButton = saveItemButton
        let textField = itemTitleTextField
        rememberEventButton.tap()
        textField.typeText(" a")
        XCTAssertTrue(saveButton.isEnabled)
    }

    func testSaveItem() {
        let tableView = itemsList
        makeTestItem(title: "Test item")
        XCTAssertFalse(sortingButton.exists)
        XCTAssertTrue(plusButton.exists)
        XCTAssertTrue(tableView.cells.firstMatch.exists)
    }

    func testDeleteItem() {
        let tableView = itemsList
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
    var itemsList: XCUIElement { app.tables["MainVC_tableView"] }
    var addNewItemButton: XCUIElement { app.buttons["EmptyView_addNewItemButton"] }
    var saveItemButton: XCUIElement { app.buttons["ItemVC_saveButton"] }
    var itemTitleTextField: XCUIElement { app.textFields["ItemVC_itemTitleTextField"] }
    var itemDatePicker: XCUIElement { app.datePickers["ItemVC_itemDatePicker"]}
    var sortingButton: XCUIElement { app.buttons["MainVC_sortingButton"] }
    var plusButton: XCUIElement { app.buttons["MainVC_addNewItemButton"] }

    func makeTestItem(
        title: String,
        isListEmpty: Bool = true
    ) {
        let rememberEventButton = addNewItemButton
        let addNewItemButton = plusButton
        let saveButton = saveItemButton
        let textField = itemTitleTextField
        if isListEmpty {
            rememberEventButton.tap()
        } else {
            addNewItemButton.tap()
        }
        textField.typeText(title)
        saveButton.tap()
    }
}
