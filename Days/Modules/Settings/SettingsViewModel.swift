import Foundation

protocol SettingsViewModelProtocol {
    var feedbackRecipients: [String] { get }
    var canDeleteAllData: Bool { get }
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

    var canDeleteAllData: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
    }

    func deleteAllData() {
        deletionService.clearDatabase()
    }
}
