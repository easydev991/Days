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
    var interactor: MainInteractorProtocol!
    var items = [Item]()
}

extension MainPresenterMock: MainPresenterProtocol {
    var title: String { "Title" }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {}

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
            completion: { error in
                if let error = error {
                    print("Error saving item at storage: \(error.localizedDescription)")
                } else {
                    items.append(testItem)
                }

            }
        )
    }

    func removeItem(at index: Int, completion: () -> Void) {
        let itemForRemoval = items.remove(at: index)
        interactor.removeItem(itemForRemoval) { error in
            if let error = error {
                print("Error removing item at storage: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }

    func reloadView() {}
}
