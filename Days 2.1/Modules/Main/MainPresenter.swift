//
//  MainPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

protocol MainPresenterProtocol: AnyObject {
    var title: String { get }
    var items: [Item] { get }
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
        interactor?.saveItem(item) { error in
            if let error = error {
                print("Error saving item at storage: \(error.localizedDescription)")
            } else {
                items.append(item)
                items.sort { $0.date > $1.date }
                reloadView()
            }
        }
    }

    func removeItem(
        at index: Int,
        completion: VoidBlock
    ) {
        let itemForRemoval = items.remove(at: index)
        interactor?.removeItem(itemForRemoval) { error in
            if let error = error {
                print("Error removing item at storage: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }

    func reloadView() {
        view?.reload()
    }
}

private extension MainPresenter {
    func dateToTextDays(item: Item) -> String {
        var resultString = NSLocalizedString("today", comment: "today")
        let today = Date()
        let calendar = Calendar.current
        let daysCount = calendar.numberOfDaysBetween(item.date, and: today)
        if daysCount != .zero {
            resultString = .localizedStringWithFormat(
                NSLocalizedString(
                    "daysPast",
                    comment: "days ago"
                ),
                daysCount
            )
        }
        return resultString
    }
}
