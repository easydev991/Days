import Foundation

protocol ItemPresenterProtocol: AnyObject {
    var router: ItemRouterProtocol? { get set }
    func viewDidLoad()
    func checkNameForLettersIn(text: String?)
    func finishFlow()
}

final class ItemPresenter {
    weak var view: ItemViewControllerProtocol?
    var router: ItemRouterProtocol?
}

extension ItemPresenter: ItemPresenterProtocol {
    func viewDidLoad() {
        view?.setSaveButton(enabled: false)
    }

    func checkNameForLettersIn(text: String?) {
        if let text {
            view?.setSaveButton(enabled: text.containsLetter)
        } else {
            view?.setSaveButton(enabled: false)
        }
    }

    func finishFlow() {
        router?.dismissViewController()
    }
}
