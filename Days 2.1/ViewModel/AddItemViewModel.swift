//
//  AddItemViewModel.swift
//  Days 2.1
//
//  Created by Олег Еременко on 29.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class AddItemViewModel {
    weak var view: AddItemViewController?
    
    func setupView(){
        view?.itemDatePicker.datePickerMode = .date
        view?.saveButton.isEnabled = false
    }
    
    func checkNameForLetters(textField: UITextField){
        if let _ = textField.text!.rangeOfCharacter(from: NSCharacterSet.letters){
            view?.saveButton.isEnabled = true
        } else {
            view?.saveButton.isEnabled = false
        }
    }
    
    func performSave(){
        view?.delegate?.setItemData(label: (view?.itemNameTextField.text!)!, date: (view?.itemDatePicker.date)!)
        view?.navigationController?.popToRootViewController(animated: true)
    }
}
