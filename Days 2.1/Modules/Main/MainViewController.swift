import UIKit

protocol MainViewControllerProtocol: ItemViewControllerDelegate {
    func reload()
    func present(_ viewController: UIViewController)
}

final class MainViewController: UIViewController {
    // MARK: - UI
    private lazy var sortingButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: .init(systemName: "arrow.up.arrow.down"),
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        button.tintColor = .buttonTint
        return button
    }()

    private lazy var addNewItemButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        button.tintColor = .buttonTint
        return button
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.register(ItemCell.self, forCellReuseIdentifier: ItemCell.cellID)
        table.translatesAutoresizingMaskIntoConstraints = false
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
    func reload() {
        tableView.reloadSections(.init(integer: .zero), with: .automatic)
    }

    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}

// MARK: - ItemDelegate
extension MainViewController: ItemViewControllerDelegate {
    func setItemData(itemName: String, itemDate: Date) {
        presenter?.saveItem(name: itemName, date: itemDate)
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
        deleteAction.image = .init(systemName: "trash")?.tint(with: .systemRed)
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
        presenter?.items.count ?? .zero
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
    func setupUI() {
        title = presenter?.title
        view.backgroundColor = .mainBackground

        navigationItem.leftBarButtonItem = sortingButton
        navigationItem.rightBarButtonItem = addNewItemButton
        navigationController?.navigationBar.barTintColor = .mainBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainTitle]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.mainTitle]

        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }

    @objc func sortButtonTapped() {
        let alert = UIAlertController(
            title: nil,
            message: Text.Main.sortBy.text,
            preferredStyle: .actionSheet
        )
        let dateDescending = UIAlertAction(
            title: Text.Button.dateDescending.text,
            style: .default
        ) { [weak presenter] _ in
            presenter?.sortBy(.dateDescending)
        }
        let dateAscending = UIAlertAction(
            title: Text.Button.dateAscending.text,
            style: .default
        ) { [weak presenter] _ in
            presenter?.sortBy(.dateAscending)
        }
        let titleDescending = UIAlertAction(
            title: Text.Button.titleDescending.text,
            style: .default
        ) { [weak presenter] _ in
            presenter?.sortBy(.titleDescending)
        }
        let titleAscending = UIAlertAction(
            title: Text.Button.titleAscending.text,
            style: .default
        ) { [weak presenter] _ in
            presenter?.sortBy(.titleAscending)
        }
        let cancelAction = UIAlertAction(
            title: Text.Button.cancel.text,
            style: .cancel
        )
        [dateDescending, dateAscending, titleDescending, titleAscending, cancelAction].forEach(alert.addAction)
        present(alert)
    }

    @objc func addButtonTapped() {
        presenter?.addItemTapped()
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
import SwiftUI

struct MainVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        AppFactory.makeRootView()
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}
}

struct MainVCPreview: PreviewProvider {
    static var previews: some View {
        MainVCRepresentable()
    }
}
#endif
