import UIKit

protocol ItemViewControllerDelegate: AnyObject {
    func setItemData(itemName: String, itemDate: Date)
}

protocol ItemViewControllerProtocol: AnyObject {
    func saveAction()
    func setSaveButton(enabled: Bool)
}

final class ItemViewController: UIViewController {
    // MARK: - UI
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

    private lazy var itemNameTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.attributedPlaceholder = .init(
            string: NSLocalizedString("Enter event placeholder", comment: "Placeholder"),
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        field.textColor = .textColor
        field.borderStyle = .roundedRect
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        field.translatesAutoresizingMaskIntoConstraints = false
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
        guard let text = itemNameTextField.text else { return }
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
        guard let text = textField.text, !text.isEmpty else { return false }
        saveAction()
        return true
    }
}

// MARK: - Private methods
private extension ItemViewController {
    func setupUI() {
        title = presenter?.title()
        view.backgroundColor = .mainBackground
        [horizontalStack, separatorView, itemNameTextField, itemDatePicker].forEach(view.addSubview)
        NSLayoutConstraint.activate(
            [
                closeButton.widthAnchor.constraint(equalToConstant: Layout.buttonWidth),
                saveButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor),
                horizontalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.defaultInset),
                horizontalStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Layout.defaultInset),
                horizontalStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Layout.defaultInset),
                separatorView.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: Layout.averageInset),
                separatorView.leftAnchor.constraint(equalTo: horizontalStack.leftAnchor),
                separatorView.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor),
                separatorView.heightAnchor.constraint(equalToConstant: 1),
                itemNameTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Layout.averageInset),
                itemNameTextField.leftAnchor.constraint(equalTo: horizontalStack.leftAnchor),
                itemNameTextField.rightAnchor.constraint(equalTo: horizontalStack.rightAnchor),
                itemDatePicker.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: Layout.defaultInset),
                itemDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter?.checkNameForLettersIn(text: textField.text)
    }

    @objc func backButtonAction() {
        presenter?.backButtonTapped()
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
import SwiftUI

struct ItemVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let itemVC = ItemViewController()
        ItemConfigurator.configure(with: itemVC)
        return itemVC
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
