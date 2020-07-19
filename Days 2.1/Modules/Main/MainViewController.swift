//
//  ViewController.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    
    let selfToItemSegueName = "MainToItemSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    func addGradient(to cell: TableViewCell, at indexPath: IndexPath){
        let calculation = CGFloat(indexPath.row) / 25
        if let colour = UIColor.systemYellow.darkened(amount: calculation) as? UIColor {
            cell.backgroundColor = colour
        }
    }
}

