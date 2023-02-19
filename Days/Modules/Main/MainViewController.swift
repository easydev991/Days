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

    private lazy var sortingButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: nil,
            image: Images.Main.sort.image,
            primaryAction: sortAction,
            menu: nil
        )
        button.tintColor = .buttonTint
        button.accessibilityIdentifier = Identifier.sortingButton.text
        return button
    }()

    private lazy var sortAction = UIAction { [unowned self] _ in
        sortButtonTapped()
    }

    private lazy var addNewItemButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            systemItem: .add,
            primaryAction: addAction,
            menu: nil
        )
        button.tintColor = .buttonTint
        button.accessibilityIdentifier = Identifier.addNewItemButton.text
        return button
    }()

    private lazy var addAction = UIAction { [unowned self] _ in
        addItemTapped()
    }

    private lazy var emptyView: EmptyView = {
        let view = EmptyView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = Identifier.emptyView.text
        return view
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.delegate = self
        table.dataSource = presenter?.dataSource
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(ItemCell.self, forCellReuseIdentifier: ItemCell.cellID)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.accessibilityIdentifier = Identifier.tableView.text
        return table
    }()

    var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.requestItems()
    }
}

extension MainViewController: MainViewControllerProtocol {
    func set(title: String?) {
        navigationItem.title = title
    }

    func reload(isListEmpty: Bool) {
        tableView.isHidden = isListEmpty
        if isListEmpty {
            tableView.reloadData()
        } else {
            tableView.reloadSections(
                .init(integer: .zero),
                with: .automatic
            )
        }
    }

    func setEmptyView(hidden: Bool) {
        emptyView.isHidden = hidden
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
        presentSimpleAlert(
            title: Text.Alert.error.localized,
            message: message
        )
    }

    func takeItem(with title: String, and date: Date) {
        presenter?.saveItem(with: title, and: date)
    }
}

extension MainViewController: EmptyViewDelegate {
    func buttonTapped() {
        addItemTapped()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: nil
        ) { [weak presenter] _, _, _ in
            presenter?.removeItem(at: indexPath.row) {
                tableView.deleteRows(
                    at: [indexPath],
                    with: .automatic
                )
            }
        }
        deleteAction.image = .init(systemName: "trash")?.colored(.systemRed)
        deleteAction.backgroundColor = .mainBackground
        return .init(actions: [deleteAction])
    }
}

private extension MainViewController {
    enum Identifier: String {
        case rootView, sortingButton, addNewItemButton, emptyView, tableView
        var text: String {
            "MainVC" + "_" + rawValue
        }
    }

    func setupUI() {
        view.backgroundColor = .mainBackground
        view.accessibilityIdentifier = Identifier.rootView.text
        [tableView, emptyView].forEach { view.addSubview($0) }
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

    func sortButtonTapped() {
        if let sortOptions = presenter?.availableSortOptions {
            let alertActions = sortOptions.map { option in
                UIAlertAction(
                    title: option.title,
                    style: .default
                ) { [weak presenter] _ in
                    presenter?.sortBy(option)
                }
            }
            let alert = UIAlertController.makeAlert(
                title: Text.Main.sortBy.localized,
                actions: alertActions
            )
            present(alert)
        }
    }

    func addItemTapped() {
        presenter?.addItemTapped()
    }
}
