//
//  Item_UITextFieldDelegate.swift
//  Days 2.1
//
//  Created by Олег Еременко on 24.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

extension ItemViewController: UITextFieldDelegate {

// Save item on Enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            return false
        }
        saveAction()
        return true
    }
}
