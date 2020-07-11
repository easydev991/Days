//
//  ItemRouter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

class ItemRouter: ItemRouterProtocol {
    
    weak var viewController: ItemViewController!
    
    init(viewController: ItemViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
