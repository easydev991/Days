//
//  ViewController.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit
import DynamicColor

protocol MainViewControllerProtocol: AnyObject {
    func reloadTableViewData()
}

final class MainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var addNewItemButton: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var presenter: MainPresenterProtocol?
    private let configurator: MainConfiguratorProtocol = MainConfigurator()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupUI()
        presenter?.requestItems()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter?.prepare(for: segue, sender: sender)
    }
}

// MARK: - MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - ItemDelegate
extension MainViewController: ItemDelegate {
    func setItemData(itemName: String, itemDate: Date) {
        presenter?.saveItem(name: itemName, date: itemDate)
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            presenter?.removeItem(
                at: indexPath,
                completion: {
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
            )
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter?.makeItemsCount() ?? .zero
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableViewCell.cellID,
            for: indexPath
        ) as? TableViewCell else {
            return UITableViewCell()
        }
        presenter?.setup(cell: cell, at: indexPath)
        return cell
    }
}

private extension MainViewController {
    func setupUI() {
        title = presenter?.title()
        navigationController?.navigationBar.barTintColor = .mainBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainTitle]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.mainTitle]

        addNewItemButton.tintColor = .buttonTint

        tableView.backgroundColor = .mainBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}
