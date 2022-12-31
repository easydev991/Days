import UIKit.UIViewController

final class SettingsConfigurator {
    static var settingsVC: UIViewController {
        let service = DeletionService()
        let viewModel = SettingsViewModel(deletionService: service)
        return SettingsViewController(viewModel: viewModel)
    }
}
