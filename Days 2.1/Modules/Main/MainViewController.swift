import UIKit

protocol MainViewControllerProtocol: ItemViewControllerDelegate {
    func reload()
    func present(_ viewController: UIViewController)
}

final class MainViewController: UIViewController {
    // MARK: - UI
    private lazy var addNewItemButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        return button
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
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
        tableView.reloadData()
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
        var rowsCount = Int.zero
        if let count = presenter?.items.count {
            rowsCount = count
        }
        return rowsCount
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

        addNewItemButton.tintColor = .buttonTint
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
        let mainVC = MainViewController()
        MainConfigurator.configure(with: mainVC)
        return mainVC
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
