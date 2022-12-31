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
        Text.Settings.viewTitle.localized
    }

    var feedbackRecipients: [String] {
        ["o.n.eremenko@gmail.com"]
    }

    var emailSubjectText: String {
        Text.Settings.feedbackSubject.localized
    }

    var emailMessageBody: String {
        Text.Settings.feedbackBody.localized
    }

    var sendEmailErrorMessage: String {
        "Cannot send emails from simulator"
    }

    var isDeleteButtonHidden: Bool {
        !deletionService.isDataAvailable
    }

    var deletionDisclaimer: String {
        Text.Settings.deletionDisclaimer.localized
    }

    func deleteAllData(completion: @escaping DeletionResult) {
        deletionService.clearDatabase { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(Text.Settings.deletionSuccess.localized))
                NotificationCenter.default.post(name: .allDataHasBeedDeleted, object: nil)
            }
        }
    }
}
