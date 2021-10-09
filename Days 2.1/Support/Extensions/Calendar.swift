//
//  Calendar.swift
//  Days 2.1
//
//  Created by Олег Еременко on 03.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ date1: Date, and date2: Date) -> Int {
        let numberOfDays = dateComponents([.day], from: date1, to: date2)
        return numberOfDays.day ?? .zero
    }
}
