//
//  ItemPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

final class ItemPresenter: ItemPresenterProtocol {

// MARK: Public properties
    
    weak var view: ItemViewProtocol!
    var interactor: ItemInteractorProtocol!
    
// MARK: Protocol properties
    
    var router: ItemRouterProtocol!
    
// MARK: Init
    
    required init(view: ItemViewProtocol) {
        self.view = view
    }
    
// MARK: Protocol methods
    
    func configureViewElements(){
        view.configureViewElements()
    }
    
    func saveButtonClicked() {
        router.closeCurrentViewController()
    }
    
    func checkNameForLetters(textField: UITextField){
        interactor.checkNameForLetters(textField: textField)
    }
    
    func enableSaveButton() {
        view.enableSaveButton()
    }
    
    func disableSaveButton() {
        view.disableSaveButton()
    }
    
}
