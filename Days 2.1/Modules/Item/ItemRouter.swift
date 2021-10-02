//
//  ItemRouter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol ItemRouterProtocol: AnyObject {
    func closeCurrentViewController()
}

final class ItemRouter {
    weak var viewController: ItemViewController?
}

extension ItemRouter: ItemRouterProtocol {
    func closeCurrentViewController() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
