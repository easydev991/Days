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

final class ItemViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - IBOutlets
    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var itemDatePicker: UIDatePicker!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    var presenter: ItemPresenterProtocol?
    weak var delegate: ItemDelegate?
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        presenter?.checkNameForLetters(textField: sender)
    }
    
    @IBAction func backButtonClicked(_ sender: UIBarButtonItem) {
        presenter?.backButtonTapped()
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
    func setupUI() {
        presenter?.viewDidLoad()
        title = presenter?.title()
        view.backgroundColor = .mainBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        [backButton, saveButton].forEach { $0?.tintColor = .buttonTint }

        itemNameTextField.attributedPlaceholder = .init(
            string: NSLocalizedString("Enter event placeholder", comment: "Placeholder"),
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        itemNameTextField.textColor = .textColor
        itemNameTextField.borderStyle = .roundedRect

        itemDatePicker.maximumDate = Date()
        itemDatePicker.datePickerMode = .date
        itemDatePicker.backgroundColor = .systemOrange
        itemDatePicker.backgroundColor = .mainBackground
        itemDatePicker.preferredDatePickerStyle = .wheels
        itemDatePicker.textColor = .textColor
        itemDatePicker.highlightsToday = false
    }
}
