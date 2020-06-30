//
//  ViewController.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainScreenViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainScreenViewModel.init()
        viewModel?.mainView = self
        viewModel?.loadItems()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddItemViewController, segue.identifier == "AddNewItem"{
            vc.delegate = self
        }
    }
}

