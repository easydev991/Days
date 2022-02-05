@testable import Days

final class ItemPresenterMock {
    var viewController: ItemViewControllerProtocol!
    var router: ItemRouterProtocol?
}

extension ItemPresenterMock: ItemPresenterProtocol {
    func viewDidLoad() {}

    func checkNameForLettersIn(text: String?) {}

    func finishFlow() {}
}
