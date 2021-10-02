//
//  ItemInteractor.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

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
