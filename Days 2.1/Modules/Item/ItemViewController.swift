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
    func saveAction()
    func setSaveButton(enabled: Bool)
}

final class ItemViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var itemDatePicker: UIDatePicker! {
        didSet {
            itemDatePicker.preferredDatePickerStyle = .wheels
            itemDatePicker.datePickerMode = .date
        }
    }
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    // MARK: - Public properties
    var presenter: ItemPresenterProtocol?
    weak var delegate: ItemDelegate?
    
    // MARK: - Private properties
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupPlaceholder()
    }
    
    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        presenter?.checkNameForLetters(textField: sender)
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        presenter?.router?.closeCurrentViewController()
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        saveAction()
    }
}

// MARK: - ItemViewControllerProtocol
extension ItemViewController: ItemViewControllerProtocol {
    func saveAction(){
        guard let text = itemNameTextField.text else {
            return
        }
        delegate?.setItemData(
            itemName: text,
            itemDate: itemDatePicker.date
        )
        presenter?.saveButtonClicked()
    }

    func setSaveButton(enabled: Bool) {
        saveButton.isEnabled = enabled
    }
}

// MARK: - UITextFieldDelegate
extension ItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
              !text.isEmpty else {
            return false
        }
        saveAction()
        return true
    }
}

// MARK: - Private methods
private extension ItemViewController {
    func initialSetup() {
        configurator.configure(with: self)
        presenter?.viewDidLoad()
    }

    func setupPlaceholder() {
        itemNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Enter a title",
            attributes: [.foregroundColor: UIColor.systemGray]
        )
    }
}
