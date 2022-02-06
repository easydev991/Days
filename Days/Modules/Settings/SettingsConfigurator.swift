import UIKit.UIViewController

final class SettingsConfigurator {
    static func makeVC() -> UIViewController {
        let service = DeletionService()
        let viewModel = SettingsViewModel(deletionService: service)
        return SettingsViewController(viewModel: viewModel)
    }
}
