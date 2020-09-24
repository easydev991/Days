//
//  MainRouter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

final class MainRouter: MainRouterProtocol {
    
// MARK: Public properties
    
    weak var viewController: MainViewController!
    
// MARK: Init
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
// MARK: Protocol methods
    
    func showItemScene() {
        viewController.performSegue(withIdentifier: viewController.selfToItemSegueName, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ItemViewController{
            vc.delegate = viewController
        }
    }
}
