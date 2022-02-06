import Foundation

protocol SettingsViewModelProtocol {
    var viewTitle: String { get }
    var feedbackRecipients: [String] { get }
    var emailSubjectText: String { get }
    var emailMessageBody: String { get }
    var sendEmailErrorMessage: String { get }
    var canDeleteAllData: Bool { get }
    var deletionDisclaimer: String { get }
    func deleteAllData(completion: DeletionResult?)

    typealias DeletionResult = (Result<String, Error>) -> Void
}

struct SettingsViewModel {
    private let deletionService: DeletionServiceProtocol

    init(deletionService: DeletionServiceProtocol) {
        self.deletionService = deletionService
    }
}

extension SettingsViewModel: SettingsViewModelProtocol {
    var viewTitle: String {
        Text.Settings.viewTitle.text
    }

    var feedbackRecipients: [String] {
        ["o.n.eremenko@gmail.com"]
    }

    var emailSubjectText: String {
        Text.Settings.feedbackSubject.text
    }

    var emailMessageBody: String {
        Text.Settings.feedbackBody.text
    }

    var sendEmailErrorMessage: String {
        "Cannot send emails"
    }

    var canDeleteAllData: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
    }

    var deletionDisclaimer: String {
        Text.Settings.deletionDisclaimer.text
    }

    func deleteAllData(completion: DeletionResult?) {
        deletionService.clearDatabase { error in
            if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.success(Text.Settings.deletionSuccess.text))
            }
        }
    }
}
