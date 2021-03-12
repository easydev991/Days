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
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Public methods
    
    func addGradient(to cell: TableViewCell, at indexPath: IndexPath){
        let calculation = CGFloat(indexPath.row) / 25
        let color = UIColor.systemYellow.darkened(amount: calculation)
        cell.backgroundColor = color
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
        let newItem = Item()
        newItem.itemName = itemName
        newItem.date = itemDate
        presenter.saveItem(item: newItem)
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(45)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellID) as! TableViewCell
        
        if let item = presenter.items?[indexPath.row] {
            cell.setupCell(itemName: item.itemName, itemDays: presenter.dateToTextDays(item: item))
            addGradient(to: cell, at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let itemForRemoval = presenter.items?[indexPath.row]{
                self.presenter.removeItem(item: itemForRemoval)
            }
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
