//
//  ItemProtocols.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol ItemViewDelegate {
    func setItemData(label: String, date: Date)
}

protocol ItemViewProtocol: AnyObject {
    func configureViewElements()
    func enableSaveButton()
    func disableSaveButton()
}

protocol ItemPresenterProtocol: AnyObject {
    var router: ItemRouterProtocol! { get set }
    func configureViewElements()
    func saveButtonClicked()
    func checkNameForLetters(textField: UITextField)
    func enableSaveButton()
    func disableSaveButton()
}

protocol ItemInteractorProtocol: AnyObject {
    func checkNameForLetters(textField: UITextField)
}

protocol ItemRouterProtocol: AnyObject {
    func closeCurrentViewController()
}

protocol ItemConfiguratorProtocol: AnyObject {
    func configure(with viewController: ItemViewController)
}
