import UIKit

protocol ItemInteractorProtocol: AnyObject {
    func checkNameForLetters(textField: UITextField)
}

final class ItemInteractor {
    weak var presenter: ItemPresenterProtocol?
}

extension ItemInteractor: ItemInteractorProtocol {
    func checkNameForLetters(textField: UITextField) {
        let textIsEmpty = textField.text?.rangeOfCharacter(from: .letters)?.isEmpty ?? true
        presenter?.setSaveButton(enabled: !textIsEmpty)
    }
}
