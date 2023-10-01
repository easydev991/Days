import UIKit

protocol ItemViewControllerDelegate: AnyObject {
    func takeItem(with title: String, and date: Date)
}

protocol ItemViewControllerProtocol: AnyObject {
    func saveAction()
    func setSaveButton(enabled: Bool)
    func dismiss()
}

final class ItemViewController: UIViewController {
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton, titleLabel, saveButton])
        stack.spacing = Layout.Insets.average
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.hStack.text
        return stack
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.separatorView.text
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.Item.viewTitle.localized
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.textColor = .adaptiveText
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.titleLabel.text
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: closeButtonAction)
        button.setTitle(Text.Button.cancel.localized, for: .normal)
        button.tintColor = .buttonTint
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = Identifier.cancelButton.text
        return button
    }()

    private lazy var closeButtonAction = UIAction { [weak presenter] _ in
        presenter?.finishFlow()
    }

    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: saveButtonAction)
        button.setTitle(Text.Button.done.localized, for: .normal)
        button.tintColor = .buttonTint
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = Identifier.saveButton.text
        return button
    }()

    private lazy var saveButtonAction = UIAction { [unowned self] _ in saveAction() }

    private lazy var itemTitleTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.attributedPlaceholder = .init(
            string: Text.Item.titlePlaceholder.localized,
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        field.textColor = .adaptiveText
        field.borderStyle = .roundedRect
        field.addAction(editingChangedAction, for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.accessibilityIdentifier = Identifier.itemTitleTextField.text
        return field
    }()

    private lazy var editingChangedAction = UIAction { [weak presenter] action in
        let textField = action.sender as? UITextField
        presenter?.checkNameForLettersIn(text: textField?.text)
    }

    private let itemDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.maximumDate = .init()
        picker.datePickerMode = .date
        picker.backgroundColor = .mainBackground
        picker.preferredDatePickerStyle = .wheels
        picker.setValue(false, forKey: "highlightsToday")
        picker.setValue(UIColor.adaptiveText, forKeyPath: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.accessibilityIdentifier = Identifier.itemDatePicker.text
        return picker
    }()

    var presenter: ItemPresenterProtocol?
    weak var delegate: ItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemTitleTextField.becomeFirstResponder()
    }
}

extension ItemViewController: ItemViewControllerProtocol {
    func saveAction() {
        if let text = itemTitleTextField.text {
            delegate?.takeItem(
                with: text,
                and: itemDatePicker.date
            )
            presenter?.finishFlow()
        }
    }

    func setSaveButton(enabled: Bool) {
        saveButton.isEnabled = enabled
    }

    func dismiss() { dismiss(animated: true) }
}

extension ItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        saveAction()
        return true
    }
}

private extension ItemViewController {
    enum Identifier: String {
        case rootView, hStack, separatorView, titleLabel, cancelButton,
             saveButton, itemTitleTextField, itemDatePicker
        var text: String {
            "ItemVC" + "_" + rawValue
        }
    }

    func setupUI() {
        view.accessibilityIdentifier = Identifier.rootView.text
        view.backgroundColor = .mainBackground
        [hStack, separatorView, itemTitleTextField, itemDatePicker].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
            hStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.Insets.standard),
            hStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Layout.Insets.standard),
            hStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Layout.Insets.standard),
            separatorView.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: Layout.Insets.average),
            separatorView.leftAnchor.constraint(equalTo: hStack.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: hStack.rightAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            itemTitleTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Layout.Insets.average),
            itemTitleTextField.leftAnchor.constraint(equalTo: hStack.leftAnchor),
            itemTitleTextField.rightAnchor.constraint(equalTo: hStack.rightAnchor),
            itemDatePicker.topAnchor.constraint(equalTo: itemTitleTextField.bottomAnchor, constant: Layout.Insets.standard),
            itemDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
