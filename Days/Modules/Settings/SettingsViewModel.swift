import FeedbackSender
import Foundation

protocol SettingsViewModelProtocol {
    var viewTitle: String { get }
    var sendEmailErrorMessage: String { get }
    var isDeleteButtonHidden: Bool { get }
    var deletionDisclaimer: String { get }
    func deleteAllData(completion: @escaping DeletionResult)
    func sendFeedback()

    typealias DeletionResult = (Result<String, Error>) -> Void
}

final class SettingsViewModel {
    private let feedbackService: FeedbackSender
    private let deletionService: DeletionServiceProtocol

    init(
        deletionService: DeletionServiceProtocol,
        feedbackService: FeedbackSender = FeedbackSenderImp()
    ) {
        self.deletionService = deletionService
        self.feedbackService = feedbackService
    }
}

extension SettingsViewModel: SettingsViewModelProtocol {
    var viewTitle: String {
        Text.Settings.viewTitle.localized
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
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(Text.Settings.deletionSuccess.localized))
                NotificationCenter.default.post(name: .allDataHasBeedDeleted, object: nil)
            }
        }
    }

    func sendFeedback() {
        feedbackService.sendFeedback(
            subject: Text.Settings.feedbackSubject.localized,
            messageBody: Text.Settings.feedbackBody.localized,
            recipients: ["o.n.eremenko@gmail.com"]
        )
    }
}
