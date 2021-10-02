//
//  ItemPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol ItemPresenterProtocol: AnyObject {
    var router: ItemRouterProtocol? { get set }
    func viewDidLoad()
    func saveButtonClicked()
    func checkNameForLetters(textField: UITextField)
    func setSaveButton(enabled: Bool)
    func backButtonTapped()
}

final class ItemPresenter {
    weak var view: ItemViewControllerProtocol?
    var interactor: ItemInteractorProtocol?
    var router: ItemRouterProtocol?
}

extension ItemPresenter: ItemPresenterProtocol {
    func viewDidLoad() {
        view?.setSaveButton(enabled: false)
    }

    func saveButtonClicked() {
        router?.closeCurrentViewController()
    }

    func checkNameForLetters(textField: UITextField) {
        interactor?.checkNameForLetters(textField: textField)
    }

    func setSaveButton(enabled: Bool) {
        view?.setSaveButton(enabled: enabled)
    }

    func backButtonTapped() {
        router?.closeCurrentViewController()
    }
}
