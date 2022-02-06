import Foundation

enum Text {
    enum Alert {
        case success
        case warning
        case error
        case dateAscending
        case dateDescending
        case titleAscending
        case titleDescending

        var text: String {
            switch self {
            case .success:
                return NSLocalizedString("Success", comment: "")
            case .warning:
                return NSLocalizedString("Warning", comment: "")
            case .error:
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
        case feedbackSubject
        case feedbackBody
        case rateTheApp
        case deleteAllData
        case deletionDisclaimer
        case deletionSuccess

        var text: String {
            switch self {
            case .viewTitle:
                return NSLocalizedString("Settings", comment: "SettingsVC title")
            case .sendFeedback:
                return NSLocalizedString("Send feedback", comment: "")
            case .feedbackSubject:
                return NSLocalizedString("Feedback_Days", comment: "")
            case .feedbackBody:
                return NSLocalizedString("Your message: ", comment: "")
            case .rateTheApp:
                return NSLocalizedString("Rate the app", comment: "")
            case .deleteAllData:
                return NSLocalizedString("Delete all data", comment: "")
            case .deletionDisclaimer:
                return NSLocalizedString("All data deletion disclaimer", comment: "")
            case .deletionSuccess:
                return NSLocalizedString("Deletion success", comment: "")
            }
        }
    }

    enum Button {
        case cancel
        case done
        case close
        case yes

        var text: String {
            switch self {
            case .cancel:
                return NSLocalizedString("Cancel", comment: "")
            case .done:
                return NSLocalizedString("Done", comment: "")
            case .close:
                return NSLocalizedString("Close", comment: "")
            case .yes:
                return NSLocalizedString("Yes", comment: "")
            }
        }
    }
}
