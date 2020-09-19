//
//  Model.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import RealmSwift

final class Item: Object {
    @objc dynamic var itemName = ""
    @objc dynamic var date = Date()
}
