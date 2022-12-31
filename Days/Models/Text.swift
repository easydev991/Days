import Foundation

enum Text {
    enum Alert: String {
        case success = "Success"
        case warning = "Warning"
        case error = "Error"
        case dateAscending = "Date ↑"
        case dateDescending = "Date ↓"
        case titleAscending = "Title ↑"
        case titleDescending = "Title ↓"

        var localized: String {
            NSLocalizedString(rawValue, comment: "")
        }
    }

    enum Main {
        case viewTitle
        case emptyList
        case today
        case daysPast(Int)
        case sortBy

        var localized: String {
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

    enum Item: String {
        case viewTitle = "Remember event"
        case titlePlaceholder = "Enter event placeholder"

        var localized: String {
            NSLocalizedString(rawValue, comment: "")
        }
    }

    enum Settings: String {
        case viewTitle = "Settings"
        case sendFeedback = "Send feedback"
        case feedbackSubject = "Feedback_Days"
        case feedbackBody = "Your message: "
        case rateTheApp = "Rate the app"
        case deleteAllData = "Delete all data"
        case deletionDisclaimer = "All data deletion disclaimer"
        case deletionSuccess = "Deletion success"

        var localized: String {
            NSLocalizedString(rawValue, comment: "")
        }
    }

    enum Button: String {
        case cancel
        case done
        case close
        case yes

        var localized: String {
            NSLocalizedString(rawValue.capitalized, comment: "")
        }
    }
}
