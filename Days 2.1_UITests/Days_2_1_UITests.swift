import XCTest

final class Days_2_1_UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testShowEmptyView() {
        app.launch()
        let emptyView = app.otherElements["MainVC_emptyView"]
        XCTAssertTrue(emptyView.exists)
    }

    func testPresentItemViewController() {
        app.launch()
        let rememberEventButton = app.buttons["EmptyView_addNewItemButton"]
        let itemVC = app.otherElements["ItemVC_rootView"]

        rememberEventButton.tap()
        XCTAssertTrue(itemVC.exists)
    }
}
