//
//  UserDefaults.swift
//  Days 2.1
//
//  Created by Олег Еременко on 24.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation

final public class NewUserCheck {
    
// MARK: Public properties
    
    static let shared = NewUserCheck()
    
// MARK: Private properties

    private let isNewUserKey = "isNewUser"
    
// MARK: Public methods

    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: isNewUserKey)
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: isNewUserKey)
    }
}
