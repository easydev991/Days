import UIKit.UIViewController

final class SettingsConfigurator {
    static func makeVC() -> UIViewController {
        let viewModel = SettingsViewModel(deletionService: DeletionService())
        return SettingsViewController(viewModel: viewModel)
    }
}
