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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var viewModel: AddItemViewModel?
    
    var delegate: AddItemDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddItemViewModel.init()
        viewModel?.view = self
        viewModel?.setupView()
    }   
    
    @IBAction func editingChanged(_ sender: UITextField) {
        viewModel?.checkNameForLetters(textField: itemNameTextField)
    }
    
    @IBAction func saveItem(_ sender: UIBarButtonItem) {
        viewModel?.performSave()
    }
}
