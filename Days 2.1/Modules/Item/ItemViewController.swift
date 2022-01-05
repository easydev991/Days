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

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                closeButton, titleLabel, saveButton
            ]
        )
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = presenter?.title()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.textColor = .textColor
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: closeButtonAction)
        button.setTitle(NSLocalizedString("Close", comment: "Close button"), for: .normal)
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemConfigurator.configure(with: self)
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemNameTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        presenter?.checkNameForLettersIn(text: sender.text)
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
        view.addSubview(horizontalStack)
        view.addSubview(separatorView)
        NSLayoutConstraint.activate(
            [
                closeButton.widthAnchor.constraint(equalToConstant: 48),
                saveButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor),
                horizontalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
                horizontalStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                horizontalStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                separatorView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 8),
                separatorView.leftAnchor.constraint(equalTo: horizontalStack.leftAnchor),
                separatorView.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1)
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
