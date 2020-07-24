//
//  ViewController.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit
import OnboardKit

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
        if let color = UIColor.systemYellow.darkened(amount: calculation) as? UIColor {
            cell.backgroundColor = color
        }
    }
    
// MARK: -  Onboarding stuff
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if NewUserCheck.shared.isNewUser() {
            let onboardingVC = OnboardViewController(pageItems: onboardingPages, appearanceConfiguration: appearance())
            onboardingVC.modalPresentationStyle = .formSheet
            onboardingVC.presentFrom(self, animated: true)
        }
    }
    
    private var onboardingPages: [OnboardPage] {
        let pageOne = OnboardPage(title: "Add a record", imageName: "add", description: "Use plus button to create a new record you would like to track")
        let pageTwo = OnboardPage(title: "Delete a record", imageName: "swipe-left", description: "Swipe left on the record to delete it", advanceButtonTitle: "Get started!")
        return [pageOne, pageTwo]
    }
    
    private func appearance() -> OnboardViewController.AppearanceConfiguration {
        return OnboardViewController.AppearanceConfiguration(tintColor: .black, backgroundColor: .systemOrange, imageContentMode: .scaleAspectFit, advanceButtonStyling: advanceButtonStyling)
    }
    
    private let advanceButtonStyling: OnboardViewController.ButtonStyling = { button in
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
    }
    
}

