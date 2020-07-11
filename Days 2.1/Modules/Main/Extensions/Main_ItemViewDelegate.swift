//
//  MainScreenVM_Delegate.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation

extension MainViewController: ItemViewDelegate {    
    func setItemData(label: String, date: Date) {
        let newItem = Item()
        newItem.itemName = label
        newItem.date = date
        presenter.saveItem(item: newItem)
    }
}
