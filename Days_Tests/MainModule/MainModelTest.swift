import XCTest
@testable import Days

final class MainModelTest: XCTestCase {
    func testNavigationItemState_none() {
        let state = MainModel.navItemState(for: .zero)
        XCTAssertEqual(state, MainViewController.VisibleNavItemButtons.none)
    }

    func testNavigationItemState_add() {
        let state = MainModel.navItemState(for: 1)
        XCTAssertEqual(state, MainViewController.VisibleNavItemButtons.add)
    }

    func testNavigationItemState_sortAndAdd() {
        let state = MainModel.navItemState(for: 2)
        XCTAssertEqual(state, MainViewController.VisibleNavItemButtons.sortAndAdd)
    }

    func testTextFrom_today() {
        let todayText = Text.Main.today.localized
        XCTAssertEqual(todayText, MainModel.textFrom(date: .now))
    }

    func testTextFrom_yesterday() {
        let daysPastForOneDayText = Text.Main.daysPast(1).localized
        let yesterday = Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: .now
        )
        XCTAssertEqual(daysPastForOneDayText, MainModel.textFrom(date: yesterday!))
    }

    func testTextFrom_manyDays() {
        let randomInt = Int.random(in: 5...50)
        let daysPastForManyDaysText = Text.Main.daysPast(randomInt).localized
        let oldDate = Calendar.current.date(
            byAdding: .day,
            value: -randomInt,
            to: .now
        )
        XCTAssertEqual(daysPastForManyDaysText, MainModel.textFrom(date: oldDate!))
    }
}
