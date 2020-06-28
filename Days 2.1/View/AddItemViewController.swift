//
//  NewItemVC.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemDatePicker: UIDatePicker!
    
    var delegate: AddItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemDatePicker.datePickerMode = .date
    }
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        delegate?.setItemData(label: itemNameTextField.text!, date: itemDatePicker.date)
        navigationController?.popToRootViewController(animated: true)
    }
}
