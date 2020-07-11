//
//  ItemInteractor.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class ItemInteractor: ItemInteractorProtocol {
    
    weak var presenter: ItemPresenterProtocol!
    
    required init(presenter: ItemPresenterProtocol) {
        self.presenter = presenter
    }
    
    func checkNameForLetters(textField: UITextField){
        if let _ = textField.text!.rangeOfCharacter(from: NSCharacterSet.letters){
            presenter.enableSaveButton()
        } else {
            presenter.disableSaveButton()
        }
    }
}
