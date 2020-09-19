//
//  ItemConfigurator.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

final class ItemConfigurator: ItemConfiguratorProtocol {
    
    func configure(with viewController: ItemViewController) {
        let presenter = ItemPresenter(view: viewController)
        let interactor = ItemInteractor(presenter: presenter)
        let router = ItemRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
