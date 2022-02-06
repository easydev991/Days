import Foundation

struct MainModel {
    static func textFrom(date: Date) -> String {
        let today = Date()
        let calendar = Calendar.current
        let daysCount = calendar.numberOfDaysBetween(date, and: today)
        return daysCount != .zero
        ? Text.Main.daysPast(daysCount).text
        : Text.Main.today.text
    }

    static func navItemState(
        for itemsCount: Int
    ) -> MainViewController.VisibleNavItemButtons {
        switch itemsCount {
        case .zero: return .none
        case 1: return .add
        default: return .sortAndAdd
        }
    }
}
