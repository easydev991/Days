import XCTest
@testable import Days_2_1

final class MainModelTest: XCTestCase {
    func testNavItemButtonsState_none() {
        let state = MainModel.navItemButtonsState(for: .zero)
        XCTAssertEqual(state, MainViewController.VisibleNavItemButtons.none)
    }

    func testNavItemButtonsState_add() {
        let state = MainModel.navItemButtonsState(for: 1)
        XCTAssertEqual(state, MainViewController.VisibleNavItemButtons.add)
    }

    func testNavItemButtonsState_sortAndAdd() {
        let state = MainModel.navItemButtonsState(for: 2)
        XCTAssertEqual(state, MainViewController.VisibleNavItemButtons.sortAndAdd)
    }

    func testTextFrom_today() {
        let todayText = Text.Main.today.text
        let today = Date()
        XCTAssertEqual(todayText, MainModel.textFrom(date: today))
    }

    func testTextFrom_yesterday() {
        let daysPastForOneDayText = Text.Main.daysPast(1).text
        let today = Date()
        let yesterday = Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: today
        )
        XCTAssertEqual(daysPastForOneDayText, MainModel.textFrom(date: yesterday!))
    }

    func testTextFrom_manyDays() {
        let randomInt = Int.random(in: 5...50)
        let daysPastForManyDaysText = Text.Main.daysPast(randomInt).text
        let today = Date()
        let oldDate = Calendar.current.date(
            byAdding: .day,
            value: -randomInt,
            to: today
        )
        XCTAssertEqual(daysPastForManyDaysText, MainModel.textFrom(date: oldDate!))
    }
}
