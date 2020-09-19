//
//  ViewController.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit
import OnboardKit
import DynamicColor

final class MainViewController: UIViewController {

// MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
// MARK: Public properties
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    let selfToItemSegueName = "MainToItemSegue"
    
// MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkNewUser()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
// MARK: Public methods
    
    func addGradient(to cell: TableViewCell, at indexPath: IndexPath){
        let calculation = CGFloat(indexPath.row) / 25
        let color = UIColor.systemYellow.darkened(amount: calculation)
        cell.backgroundColor = color
    }
    
// MARK: Onboarding properties and methods
    
    private var onboardingPages: [OnboardPage] {
        let pageOne = OnboardPage(title: "Add a record", imageName: "add", description: "Use plus button to create a new record you would like to track")
        let pageTwo = OnboardPage(title: "Delete a record", imageName: "swipe-left", description: "Swipe left on the record to delete it", advanceButtonTitle: "Get started!")
        return [pageOne, pageTwo]
    }
    
    private let advanceButtonStyling: OnboardViewController.ButtonStyling = { button in
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    }
    
    private func appearance() -> OnboardViewController.AppearanceConfiguration {
        return OnboardViewController.AppearanceConfiguration(tintColor: .black, backgroundColor: .systemOrange, imageContentMode: .scaleAspectFit, advanceButtonStyling: advanceButtonStyling)
    }
    
    private func checkNewUser() {
        if NewUserCheck.shared.isNewUser() {
            let onboardingVC = OnboardViewController(pageItems: onboardingPages, appearanceConfiguration: appearance())
            onboardingVC.modalPresentationStyle = .formSheet
            onboardingVC.presentFrom(self, animated: true)
        }
    }
    
}

// MARK: MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
}

// MARK: ItemViewDelegate

extension MainViewController: ItemViewDelegate {
    
    func setItemData(label: String, date: Date) {
        let newItem = Item()
        newItem.itemName = label
        newItem.date = date
        presenter.saveItem(item: newItem)
    }
    
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        if let item = presenter.items?[indexPath.row] {
            cell.itemNameLabel.text = item.itemName
            cell.itemDaysLabel.text = presenter.dateToTextDays(item: item)
            addGradient(to: cell, at: indexPath)
        } else {
            cell.itemNameLabel.text = "Nothing added yet"
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

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
