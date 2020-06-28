//
//  VC_Delegate.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let item = viewModel?.items?[indexPath.row]{
//            do {
//                try viewModel?.realm.write {
//                    item.done = !item.done
//                }
//            } catch {
//                print("Error saving task status, \(error)")
//            }
//        }
//        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
