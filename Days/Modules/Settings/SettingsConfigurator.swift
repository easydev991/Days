import UIKit.UIViewController

struct SettingsConfigurator {
    static func makeSettingsVC() -> UIViewController {
        let viewModel = SettingsViewModel(deletionService: DeletionService())
        return SettingsViewController(viewModel: viewModel)
    }
}
