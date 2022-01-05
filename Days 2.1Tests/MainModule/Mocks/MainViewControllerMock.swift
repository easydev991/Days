import UIKit
@testable import Days_2_1

final class MainViewControllerMock {
    var reloadComplete = false

    var testSegue: UIStoryboardSegue {
        let sourceVC = MainViewController()
        let destinationVC = ItemViewController()
        return .init(
            identifier: nil,
            source: sourceVC,
            destination: destinationVC
        )
    }
}

extension MainViewControllerMock: MainViewControllerProtocol {
    func setItemData(itemName: String, itemDate: Date) {}

    func reload() {
        reloadComplete.toggle()
    }
}
