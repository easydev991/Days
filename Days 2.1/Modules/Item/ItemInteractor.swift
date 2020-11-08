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

final class ItemInteractor: ItemInteractorProtocol {
    
// MARK: Public properties
    
    weak var presenter: ItemPresenterProtocol!
    
// MARK: Init
    
    required init(presenter: ItemPresenterProtocol) {
        self.presenter = presenter
    }
    
// MARK: Protocol methods
    
    func checkNameForLetters(textField: UITextField) {
        if let _ = textField.text!.rangeOfCharacter(from: NSCharacterSet.letters) {
            presenter.enableSaveButton()
        } else {
            presenter.disableSaveButton()
        }
    }
    
}
