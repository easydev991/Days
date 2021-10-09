//
//  Results.swift
//  Days 2.1
//
//  Created by Олег Еременко on 09.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        compactMap { $0 }
    }
}
