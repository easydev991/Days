//
//  ItemPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

final class ItemPresenter: ItemPresenterProtocol {
   
    weak var view: ItemViewProtocol!
    var interactor: ItemInteractorProtocol!
    var router: ItemRouterProtocol!
    
    required init(view: ItemViewProtocol) {
        self.view = view
    }
    
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
