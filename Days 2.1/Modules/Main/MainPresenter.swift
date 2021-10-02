//
//  MainPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import RealmSwift

protocol MainPresenterProtocol: AnyObject {
    func requestItems()
    func reloadTVData()
    func addItem(with title: String)
    func removeItem(item: Item)
    func saveItem(item: Item)
    func dateToTextDays(item: Item) -> String
    func addButtonClicked()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func makeItemsCount() -> Int?
    var router: MainRouterProtocol? { set get }
    var items: Results<Item>? { get set }
    var realm: Realm { get }
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    var items: Results<Item>?
    let realm = try! Realm()
}

extension MainPresenter: MainPresenterProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepare(for: segue, sender: sender)
    }

    func makeItemsCount() -> Int? {
        items?.count
    }

    func requestItems() {
        interactor?.loadItems()
    }

    func addItem(with title: String) {
        interactor?.addItem(with: title)
    }

    func reloadTVData() {
        view?.reloadTableViewData()
    }

    func removeItem(item: Item) {
        interactor?.removeItem(item: item)
    }

    func saveItem(item: Item) {
        interactor?.saveItem(item: item)
    }

    func dateToTextDays(item: Item) -> String {
        interactor?.dateToTextDays(item: item) ?? String()
    }

    func addButtonClicked() {
        router?.showItemScene()
    }
}
