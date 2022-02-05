import Foundation

enum Text {
    enum Alert {
        case errorTitle
        case dateAscending
        case dateDescending
        case titleAscending
        case titleDescending

        var text: String {
            switch self {
            case .errorTitle:
                return NSLocalizedString("Error", comment: "")
            case .dateAscending:
                return NSLocalizedString("Date ↑", comment: "")
            case .dateDescending:
                return NSLocalizedString("Date ↓", comment: "")
            case .titleAscending:
                return NSLocalizedString("Title ↑", comment: "")
            case .titleDescending:
                return NSLocalizedString("Title ↓", comment: "")
            }
        }
    }

    enum Main {
        case viewTitle
        case emptyList
        case today
        case daysPast(Int)
        case sortBy

        var text: String {
            switch self {
            case .viewTitle:
                return NSLocalizedString("Days have passed", comment: "MainVC title")
            case .emptyList:
                return NSLocalizedString("Items list is empty", comment: "")
            case .today:
                return NSLocalizedString("today", comment: "")
            case .daysPast(let count):
                return .localizedStringWithFormat(
                    NSLocalizedString("daysPast", comment: "days ago"),
                    count
                )
            case .sortBy:
                return NSLocalizedString("Sort by", comment: "")
            }
        }
    }

    enum Item {
        case viewTitle
        case titlePlaceholder

        var text: String {
            switch self {
            case .viewTitle:
                return NSLocalizedString("Remember event", comment: "ItemVC title")
            case .titlePlaceholder:
                return NSLocalizedString("Enter event placeholder", comment: "")
            }
        }
    }

    enum Settings {
        case viewTitle
        case sendFeedback
        case rateTheApp

        var text: String {
            switch self {
            case .viewTitle:
                return NSLocalizedString("Settings", comment: "SettingsVC title")
            case .sendFeedback:
                return NSLocalizedString("Send feedback", comment: "")
            case .rateTheApp:
                return NSLocalizedString("Rate the app", comment: "")
            }
        }
    }

    enum Button {
        case cancel
        case save
        case close

        var text: String {
            switch self {
            case .cancel:
                return NSLocalizedString("Cancel", comment: "")
            case .save:
                return NSLocalizedString("Done", comment: "")
            case .close:
                return NSLocalizedString("Close", comment: "")
            }
        }
    }
}
