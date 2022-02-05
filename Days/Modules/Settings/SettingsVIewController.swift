import UIKit

final class SettingsVIewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension SettingsVIewController {
    func setupUI() {
        navigationItem.title = Text.Settings.viewTitle.text
    }
}
