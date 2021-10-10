//
//  MainPresenterMock.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import UIKit
@testable import Days_2_1

final class MainPresenterMock {
    var viewController: MainViewControllerProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    var items = [Item]()
}

extension MainPresenterMock: MainPresenterProtocol {
    var title: String { "Title" }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(for: segue, sender: sender)
    }

    func requestItems() {
        items = interactor.loadItems(sortedBy: .itemName, ascending: true)
    }

    func setup(cell: TableViewCellInput, at index: Int) {}

    func saveItem(name: String, date: Date) {
        let testItem = Item()
        testItem.itemName = name
        testItem.date = date
        interactor.saveItem(
            testItem,
            completion: { _ in
                items.append(testItem)
            }
        )
    }

    func removeItem(at index: Int, completion: () -> Void) {
        let itemForRemoval = items.remove(at: index)
        interactor.removeItem(itemForRemoval) { _ in
            completion()
        }
    }

    func reloadView() {}
}
