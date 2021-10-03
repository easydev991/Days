//
//  MainPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import RealmSwift
import UIKit

protocol MainPresenterProtocol: AnyObject {
    var router: MainRouterProtocol? { set get }
    var items: Results<Item>? { get set }
    var realm: Realm { get }
    func title() -> String
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func makeItemsCount() -> Int?
    func requestItems()
    func reloadTVData()
    func setup(cell: TableViewCellInput, at indexPath: IndexPath)
    func saveItem(name: String, date: Date)
    func removeItem(at intexPath: IndexPath, completion: (() -> Void))
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    var items: Results<Item>?
    let realm = try! Realm()
}

extension MainPresenter: MainPresenterProtocol {
    func title() -> String {
        NSLocalizedString("Days have passed...", comment: "MainVC title")
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepare(for: segue, sender: sender)
    }

    func makeItemsCount() -> Int? {
        items?.count
    }

    func requestItems() {
        interactor?.loadItems()
    }

    func setup(cell: TableViewCellInput, at indexPath: IndexPath) {
        if let item = items?[indexPath.row] {
            let itemDays = dateToTextDays(item: item)
            let colorCalculation = CGFloat(indexPath.row) / 25
            let model = TableViewCell.Model(
                itemName: item.itemName,
                itemDays: itemDays,
                colorCalculation: colorCalculation
            )
            cell.setup(with: model)
        }
    }

    func reloadTVData() {
        view?.reloadTableViewData()
    }

    func removeItem(at intexPath: IndexPath, completion: (() -> Void)) {
        if let itemForRemoval = items?[intexPath.row] {
            interactor?.removeItem(item: itemForRemoval)
            completion()
        }
    }

    func saveItem(name: String, date: Date) {
        let item = Item()
        item.itemName = name
        item.date = date
        interactor?.saveItem(item: item)
    }
}

private extension MainPresenter {
    func dateToTextDays(item: Item) -> String {
        let today = Date()
        let calendar = Calendar.current
        let daysCount = calendar.numberOfDaysBetween(item.date, and: today)
        return daysCount == .zero
        ? NSLocalizedString("today", comment: "today")
        : .localizedStringWithFormat(NSLocalizedString("daysPast", comment: "days left in future"), daysCount)
    }
}
