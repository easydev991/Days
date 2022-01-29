import Foundation

protocol ItemPresenterProtocol: AnyObject {
    var router: ItemRouterProtocol? { get set }
    func viewDidLoad()
    var title: String { get }
    func checkNameForLettersIn(text: String?)
    func setSaveButton(enabled: Bool)
    func finishFlow()
}

final class ItemPresenter {
    weak var view: ItemViewControllerProtocol?
    var interactor: ItemInteractorProtocol?
    var router: ItemRouterProtocol?
}

extension ItemPresenter: ItemPresenterProtocol {
    var title: String {
        Text.Item.viewTitle.text
    }

    func viewDidLoad() {
        view?.setSaveButton(enabled: false)
    }

    func checkNameForLettersIn(text: String?) {
        interactor?.checkNameForLettersIn(string: text)
    }

    func setSaveButton(enabled: Bool) {
        view?.setSaveButton(enabled: enabled)
    }

    func finishFlow() {
        router?.dismissViewController()
    }
}
