//
//  MainProtocols.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import RealmSwift

protocol MainViewProtocol: AnyObject {
    func reloadTableViewData()
}

protocol MainPresenterProtocol: AnyObject {
    func configureView()
    func reloadTVData()
    func addItem(with title: String)
    func removeItem(item: Item)
    func saveItem(item: Item)
    func dateToTextDays(item: Item) -> String
    func addButtonClicked()
    var router: MainRouterProtocol! { set get }
    var items: Results<Item>? { get set }
    var realm: Realm { get }
}

protocol MainInteractorProtocol: AnyObject {
    func loadItems()
    func saveItem(item: Item)
    func removeItem(item: Item)
    func addItem(with title: String)
    func dateToTextDays(item: Item) -> String
}

protocol MainRouterProtocol: AnyObject {
    func showItemScene()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol MainConfiguratorProtocol: AnyObject {
    func configure(with viewController: MainViewController)
}
