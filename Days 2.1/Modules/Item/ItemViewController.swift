//
//  NewItemVC.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol ItemViewControllerDelegate: AnyObject {
    func setItemData(itemName: String, itemDate: Date)
}

protocol ItemViewControllerProtocol: AnyObject {
    func saveAction()
    func setSaveButton(enabled: Bool)
}

final class ItemViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var itemNameTextField: UITextField!
    @IBOutlet private weak var itemDatePicker: UIDatePicker!

    private lazy var pinView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close, primaryAction: closeButtonAction)
        button.tintColor = .buttonTint
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var closeButtonAction = UIAction { [weak presenter] _ in
        presenter?.backButtonTapped()
    }

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: saveButtonAction)
        button.setTitle(NSLocalizedString("Save", comment: "Save button"), for: .normal)
        button.tintColor = .buttonTint
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var saveButtonAction = UIAction { [unowned self] _ in
        self.saveAction()
    }
    
    // MARK: - Properties
    var presenter: ItemPresenterProtocol?
    weak var delegate: ItemViewControllerDelegate?
    private let configurator: ItemConfiguratorProtocol = ItemConfigurator()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemNameTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        presenter?.checkNameForLetters(textField: sender)
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

        [closeButton, pinView, saveButton].forEach(view.addSubview)
        NSLayoutConstraint.activate(
            [
                closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                pinView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
                pinView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pinView.heightAnchor.constraint(equalToConstant: 2),
                pinView.widthAnchor.constraint(equalToConstant: 48),
                saveButton.topAnchor.constraint(equalTo: closeButton.topAnchor),
                saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
            ]
        )
        itemNameTextField.attributedPlaceholder = .init(
            string: NSLocalizedString("Enter event placeholder", comment: "Placeholder"),
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        itemNameTextField.textColor = .textColor
        itemNameTextField.borderStyle = .roundedRect

        itemDatePicker.maximumDate = Date()
        itemDatePicker.datePickerMode = .date
        itemDatePicker.backgroundColor = .mainBackground
        itemDatePicker.preferredDatePickerStyle = .wheels
        itemDatePicker.textColor = .textColor
        itemDatePicker.highlightsToday = false
    }

    @objc func backButtonAction() {
        presenter?.backButtonTapped()
    }
}
