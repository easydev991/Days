//
//  ItemConfigurator.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

protocol ItemConfiguratorProtocol: AnyObject {
    func configure(with viewController: ItemViewController)
}

final class ItemConfigurator: ItemConfiguratorProtocol {
    func configure(with viewController: ItemViewController) {
        let presenter            = ItemPresenter()
        let interactor           = ItemInteractor()
        let router               = ItemRouter()
        presenter.view           = viewController
        viewController.presenter = presenter
        presenter.interactor     = interactor
        interactor.presenter     = presenter
        presenter.router         = router
        router.viewController    = viewController
    }
}
