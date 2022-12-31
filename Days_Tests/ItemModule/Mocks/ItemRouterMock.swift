@testable import Days

final class ItemRouterMock {
    var viewController: ItemViewController!
    var didDismiss = false
}

extension ItemRouterMock: ItemRouterProtocol {
    func dismissViewController() { didDismiss.toggle() }
}
