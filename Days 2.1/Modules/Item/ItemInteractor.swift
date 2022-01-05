protocol ItemInteractorProtocol: AnyObject {
    func checkNameForLettersIn(string: String?)
}

final class ItemInteractor {
    weak var presenter: ItemPresenterProtocol?
}

extension ItemInteractor: ItemInteractorProtocol {
    func checkNameForLettersIn(string: String?) {
        let textIsEmpty = string?.rangeOfCharacter(from: .letters)?.isEmpty ?? true
        presenter?.setSaveButton(enabled: !textIsEmpty)
    }
}
