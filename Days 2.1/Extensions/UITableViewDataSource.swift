//
//  VC_DataSource.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        if let item = viewModel?.items?[indexPath.row] {
            cell.itemNameLabel.text = item.itemName
            cell.itemDaysLabel.text = viewModel?.dateToTextDays(item: item)
        } else {
            cell.itemNameLabel.text = "Nothing added yet"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let itemForRemoval = viewModel?.items?[indexPath.row]{
                do {
                    try viewModel?.realm.write {
                        viewModel?.realm.delete(itemForRemoval)
                    }
                    
                } catch {
                    print("Error deleting item, \(error)")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .left) //deleteRows дополнительно выполняет reloadData()
        }
    }
}
