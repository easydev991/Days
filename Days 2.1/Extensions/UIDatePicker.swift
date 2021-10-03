//
//  UIDatePicker.swift
//  Days 2.1
//
//  Created by Олег Еременко on 03.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import UIKit

extension UIDatePicker {
    var textColor: UIColor? {
        get { value(forKeyPath: "textColor") as? UIColor }
        set { setValue(newValue, forKeyPath: "textColor") }
    }

    var highlightsToday: Bool? {
        get { value(forKeyPath: "highlightsToday") as? Bool }
        set { setValue(newValue, forKey: "highlightsToday") }
    }
}
