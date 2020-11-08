//
//  NewItemVC.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol ItemDelegate: AnyObject {
    func setItemData(itemName: String, itemDate: Date)
}

protocol ItemViewControllerProtocol: AnyObject {
    func configureViewElements()
    func enableSaveButton()
    func disableSaveButton()
    func saveAction()
}

final class ItemViewController: UIViewController {
   
// MARK: IBOutlets
    
    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var itemDatePicker: UIDatePicker!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
// MARK: Public properties
    
    var presenter: ItemPresenterProtocol!
    weak var delegate: ItemDelegate?
    
// MARK: Private properties
    
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()
    
// MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupPlaceholder()
    }   
    
// MARK: IBActions
    
    @IBAction func editingChanged(_ sender: UITextField) {
        presenter.checkNameForLetters(textField: sender)
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        presenter.router.closeCurrentViewController()
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        saveAction()
    }
       
// MARK: Private methods
    
    private func initialSetup() {
        configurator.configure(with: self)
        presenter.configureViewElements()
    }
    
    private func setupPlaceholder() {
        itemNameTextField.attributedPlaceholder = NSAttributedString(string: "Enter a title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
    }
    
}

// MARK: ItemViewProtocol

extension ItemViewController: ItemViewControllerProtocol {
    
    func saveAction(){
        delegate?.setItemData(itemName: itemNameTextField.text!, itemDate: itemDatePicker.date)
        presenter.saveButtonClicked()
    }
    
    func configureViewElements() {
        disableSaveButton()
        itemDatePicker.datePickerMode = .date
    }
    
    func enableSaveButton() {
        saveButton.isEnabled = true
    }
    
    func disableSaveButton() {
        saveButton.isEnabled = false
    }
}

// MARK: UITextFieldDelegate

extension ItemViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.isEmpty { return false }
        saveAction()
        return true
    }
}
