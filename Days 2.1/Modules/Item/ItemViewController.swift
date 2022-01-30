import UIKit

protocol ItemViewControllerDelegate: AnyObject {
    func takeItem(with name: String, and date: Date)
}

protocol ItemViewControllerProtocol: AnyObject {
    func saveAction()
    func setSaveButton(enabled: Bool)
    func dismiss()
}

final class ItemViewController: UIViewController {
    // MARK: - UI
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                cancelButton, titleLabel, saveButton
            ]
        )
        stack.spacing = Layout.Insets.average
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = Identifier.hStack.text
        return stack
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.separatorView.text
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Text.Item.viewTitle.text
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.textColor = .textColor
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = Identifier.titleLabel.text
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: closeButtonAction)
        button.setTitle(Text.Button.cancel.text, for: .normal)
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
        button.setTitle(Text.Button.save.text, for: .normal)
        button.tintColor = .buttonTint
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = Identifier.saveButton.text
        return button
    }()

    private lazy var saveButtonAction = UIAction { [unowned self] _ in
        self.saveAction()
    }

    private lazy var itemNameTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.attributedPlaceholder = .init(
            string: Text.Item.titlePlaceholder.text,
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        field.textColor = .textColor
        field.borderStyle = .roundedRect
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.accessibilityIdentifier = Identifier.itemNameTextField.text
        return field
    }()

    private lazy var itemDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.maximumDate = Date()
        picker.datePickerMode = .date
        picker.backgroundColor = .mainBackground
        picker.preferredDatePickerStyle = .wheels
        picker.setValue(false, forKey: "highlightsToday")
        picker.setValue(UIColor.textColor, forKeyPath: "textColor")
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.accessibilityIdentifier = Identifier.itemDatePicker.text
        return picker
    }()
    
    // MARK: - Properties
    var presenter: ItemPresenterProtocol?
    weak var delegate: ItemViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemNameTextField.becomeFirstResponder()
    }
}

// MARK: - ItemViewControllerProtocol
extension ItemViewController: ItemViewControllerProtocol {
    func saveAction(){
        if let text = itemNameTextField.text {
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

    func dismiss() {
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension ItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        saveAction()
        return true
    }
}

// MARK: - Private methods
private extension ItemViewController {
    enum Identifier: String {
        case rootView, hStack, separatorView, titleLabel, cancelButton,
             saveButton, itemNameTextField, itemDatePicker
        var text: String {
            "ItemVC" + "_" + self.rawValue
        }
    }

    func setupUI() {
        view.accessibilityIdentifier = Identifier.rootView.text
        view.backgroundColor = .mainBackground
        [hStack, separatorView, itemNameTextField, itemDatePicker].forEach(view.addSubview)
        NSLayoutConstraint.activate(
            [
                cancelButton.widthAnchor.constraint(equalToConstant: Layout.Button.Navigation.width),
                saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
                hStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.Insets.standard),
                hStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Layout.Insets.standard),
                hStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Layout.Insets.standard),
                separatorView.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: Layout.Insets.average),
                separatorView.leftAnchor.constraint(equalTo: hStack.leftAnchor),
                separatorView.rightAnchor.constraint(equalTo: hStack.rightAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1),
                itemNameTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Layout.Insets.average),
                itemNameTextField.leftAnchor.constraint(equalTo: hStack.leftAnchor),
                itemNameTextField.rightAnchor.constraint(equalTo: hStack.rightAnchor),
                itemDatePicker.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: Layout.Insets.standard),
                itemDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter?.checkNameForLettersIn(text: textField.text)
    }

    @objc func backButtonAction() {
        presenter?.finishFlow()
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
import SwiftUI

struct ItemVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ItemConfigurator.configure(with: nil)
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}
}

struct ItemVCPreview: PreviewProvider {
    static var previews: some View {
        ItemVCRepresentable()
    }
}
#endif
