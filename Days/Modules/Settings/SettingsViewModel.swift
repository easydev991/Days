import Foundation

protocol SettingsViewModelProtocol {
    var viewTitle: String { get }
    var feedbackRecipients: [String] { get }
    var emailSubjectText: String { get }
    var emailMessageBody: String { get }
    var sendEmailErrorMessage: String { get }
    var isDeleteButtonHidden: Bool { get }
    var deletionDisclaimer: String { get }
    func deleteAllData(completion: @escaping DeletionResult)

    typealias DeletionResult = (Result<String, Error>) -> Void
}

final class SettingsViewModel {
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
        "Cannot send emails from simulator"
    }

    var isDeleteButtonHidden: Bool {
        !deletionService.isDataAvailable
    }

    var deletionDisclaimer: String {
        Text.Settings.deletionDisclaimer.text
    }

    func deleteAllData(completion: @escaping DeletionResult) {
        deletionService.clearDatabase { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(Text.Settings.deletionSuccess.text))
                NotificationCenter.default.post(name: .allDataHasBeedDeleted, object: nil)
            }
        }
    }
}
