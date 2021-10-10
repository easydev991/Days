//
//  MainPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    var items: [Item] { get }
    var title: String { get }
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func requestItems()
    func setup(cell: TableViewCellInput, at index: Int)
    func saveItem(name: String, date: Date)
    func removeItem(at index: Int, completion: VoidBlock)
    func reloadView()
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    var items = [Item]()
}

extension MainPresenter: MainPresenterProtocol {
    var title: String {
        NSLocalizedString("Days have passed...", comment: "MainVC title")
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepare(for: segue, sender: sender)
    }

    func requestItems() {
        if let receivedItems = interactor?.loadItems(
            sortedBy: .date,
            ascending: false
        ) {
            items = receivedItems
            reloadView()
        }
    }

    func setup(
        cell: TableViewCellInput,
        at index: Int
    ) {
        let item = items[index]
        let itemDays = dateToTextDays(item: item)
        let model = TableViewCell.Model(
            itemName: item.itemName,
            itemDays: itemDays
        )
        cell.setup(with: model)
    }

    func saveItem(
        name: String,
        date: Date
    ) {
        let item = Item()
        item.itemName = name
        item.date = date
        interactor?.saveItem(item) {
            items.append(item)
            reloadView()
        }
    }

    func removeItem(
        at index: Int,
        completion: VoidBlock
    ) {
        let itemForRemoval = items.remove(at: index)
        interactor?.removeItem(itemForRemoval) {
            completion()
        }
    }

    func reloadView() {
        view?.reload()
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
