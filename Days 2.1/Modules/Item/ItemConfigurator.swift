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
    
// MARK: Protocol methods
    
    func configure(with viewController: ItemViewController) {
        let presenter = ItemPresenter(view: viewController)
        let interactor = ItemInteractor(presenter: presenter)
        let router = ItemRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
}
