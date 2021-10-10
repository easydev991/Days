//
//  ItemViewControllerMock.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import UIKit
@testable import Days_2_1

final class ItemViewControllerMock  {
    var delegate: ItemViewControllerDelegate!
    var savedItem = false
    var saveButtonEnabled = false
}

extension ItemViewControllerMock: ItemViewControllerProtocol {
    func saveAction() {
        savedItem.toggle()
    }

    func setSaveButton(enabled: Bool) {
        saveButtonEnabled = enabled
    }
}
