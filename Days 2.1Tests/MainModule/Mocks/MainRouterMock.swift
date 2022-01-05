import UIKit
@testable import Days_2_1

final class MainRouterMock: MainRouterProtocol {
    var prepared = false

    func prepare(for controller: UIViewController?) {
        prepared.toggle()
    }
}
