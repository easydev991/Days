//
//  MainConfigurator.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

protocol MainConfiguratorProtocol: AnyObject {
    func configure(with viewController: MainViewController)
}

final class MainConfigurator: MainConfiguratorProtocol {
    func configure(with viewController: MainViewController) {
        let presenter            = MainPresenter()
        let interactor           = MainInteractor()
        let router               = MainRouter()
        presenter.view           = viewController
        viewController.presenter = presenter
        presenter.interactor     = interactor
        interactor.presenter     = presenter
        presenter.router         = router
        router.viewController    = viewController
    }
}
