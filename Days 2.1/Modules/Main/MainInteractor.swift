//
//  MainInteractor.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func saveItem(_ item: Item, completion: OptionalErrorVoidBlock)
    func removeItem(_ item: Item, completion: OptionalErrorVoidBlock)
    func loadItems(sortedBy: ItemsSort, ascending: Bool) -> [Item]
}

final class MainInteractor {
    private let itemStorage: ItemStorageService
    weak var presenter: MainPresenterProtocol?

    init(itemStorage: ItemStorageService) {
        self.itemStorage = itemStorage
    }
}

extension MainInteractor: MainInteractorProtocol {
    func loadItems(
        sortedBy: ItemsSort,
        ascending: Bool
    ) -> [Item] {
        itemStorage.loadItems(
            sortedBy: .date,
            ascending: ascending
        )
    }

    func saveItem(
        _ item: Item,
        completion: OptionalErrorVoidBlock
    ) {
        itemStorage.saveItem(item: item) { error in
            completion(error)
        }
    }

    func removeItem(
        _ item: Item,
        completion: OptionalErrorVoidBlock
    ) {
        itemStorage.remove(item: item) { error in
            completion(error)
        }
    }
}
