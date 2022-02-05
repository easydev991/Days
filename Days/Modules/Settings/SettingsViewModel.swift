import Foundation

protocol SettingsViewModelProtocol {
    var feedbackRecipients: [String] { get }
    func deleteAllData()
}

struct SettingsViewModel {
    private let deletionService: DeletionServiceProtocol

    init(deletionService: DeletionServiceProtocol) {
        self.deletionService = deletionService
    }
}

extension SettingsViewModel: SettingsViewModelProtocol {
    var feedbackRecipients: [String] {
        ["o.n.eremenko@gmail.com"]
    }

    func deleteAllData() {
        deletionService.clearDatabase()
    }
}
