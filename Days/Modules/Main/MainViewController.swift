import UIKit

protocol MainViewControllerProtocol: ItemViewControllerDelegate {
    func reload(isListEmpty: Bool)
    func set(title: String?)
    func setEmptyView(hidden: Bool)
    func setNavItemButtons(_ state: MainViewController.VisibleNavItemButtons)
    func showError(_ message: String)
    func present(_ viewController: UIViewController)
}

final class MainViewController: UIViewController {
    enum VisibleNavItemButtons {
        case add, sortAndAdd, none
    }

    // MARK: - UI
    private lazy var sortingButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Images.Main.sort.image,
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        button.tintColor = .buttonTint
        button.accessibilityIdentifier = Identifier.sortingButton.text
        return button
    }()
    private lazy var addNewItemButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        button.tintColor = .buttonTint
        button.accessibilityIdentifier = Identifier.addNewItemButton.text
        return button
    }()
    private lazy var emptyView: EmptyView = {
        let view = EmptyView(delegate: self)
        view.alpha = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.emptyView.text
        return view
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(ItemCell.self, forCellReuseIdentifier: ItemCell.cellID)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.accessibilityIdentifier = Identifier.tableView.text
        return table
    }()

    // MARK: - Properties
    var presenter: MainPresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.requestItems()
    }
}

// MARK: - MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func set(title: String?) {
        navigationItem.title = title
    }

    func reload(isListEmpty: Bool) {
        tableView.isHidden = isListEmpty
        if !isListEmpty {
            emptyView.alpha = .zero
            tableView.reloadSections(
                .init(integer: .zero),
                with: .automatic
            )
        } else {
            emptyView.fadeIn()
        }
    }

    func setEmptyView(hidden: Bool) {
        emptyView.fadeTo(hidden ? .zero : 1)
    }

    func setNavItemButtons(_ state: MainViewController.VisibleNavItemButtons) {
        switch state {
        case .add:
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = addNewItemButton
        case .sortAndAdd:
            navigationItem.leftBarButtonItem = sortingButton
            navigationItem.rightBarButtonItem = addNewItemButton
        case .none:
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
        }
    }

    func showError(_ message: String) {
        showAlertWith(
            title: Text.Alert.error,
            message: message
        )
    }

    func takeItem(with name: String, and date: Date) {
        presenter?.saveItem(with: name, and: date)
    }
}

// MARK: - EmptyViewDelegate
extension MainViewController: EmptyViewDelegate {
    func buttonTapped() {
        addButtonTapped()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: nil,
            handler: { [weak presenter] _,_,_ in
                presenter?.removeItem(
                    at: indexPath.row,
                    completion: {
                        tableView.deleteRows(
                            at: [indexPath],
                            with: .automatic
                        )
                    }
                )
            }
        )
        deleteAction.image = .init(systemName: "trash")?.colored(.systemRed)
        deleteAction.backgroundColor = .mainBackground
        return .init(actions: [deleteAction])
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter?.itemsCount ?? .zero
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemCell.cellID,
            for: indexPath
        ) as? ItemCell {
            presenter?.setup(
                cell: cell,
                at: indexPath.row
            )
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - Private extension
private extension MainViewController {
    enum Identifier: String {
        case rootView, sortingButton, addNewItemButton, emptyView, tableView
        var text: String {
            "MainVC" + "_" + self.rawValue
        }
    }

    func setupUI() {
        view.backgroundColor = .mainBackground
        view.accessibilityIdentifier = Identifier.rootView.text
        [tableView, emptyView].forEach(view.addSubview)
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }

    @objc func sortButtonTapped() {
        if let sortOptions = presenter?.availableSortOptions {
            let alertActions = sortOptions.map { option in
                return UIAlertAction(
                    title: option.title,
                    style: .default,
                    handler: { [weak presenter] _ in
                        presenter?.sortBy(option)
                    }
                )
            }
            let alert = UIAlertController.makeAlertWith(
                title: Text.Main.sortBy.text,
                actions: alertActions
            )
            present(alert)
        }
    }

    @objc func addButtonTapped() {
        presenter?.addItemTapped()
    }
}
