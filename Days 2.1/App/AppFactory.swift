//
//  AppFactory.swift
//  Days 2.1
//
//  Created by Олег Еременко on 22.01.2022.
//  Copyright © 2022 Oleg Eremenko. All rights reserved.
//

import UIKit.UIViewController

struct AppFactory {
    static func makeRootView() -> UIViewController {
        let mainView = MainConfigurator.makeMainVC()
        return UINavigationController(rootViewController: mainView)
    }
}
