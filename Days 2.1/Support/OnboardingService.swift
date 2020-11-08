//
//  UserDefaults.swift
//  Days 2.1
//
//  Created by Олег Еременко on 24.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation
import OnboardKit

final public class OnboardingService {
    
// MARK: Public properties
    
    static let shared = OnboardingService()
    
// MARK: Private properties

    private let isNewUserKey = "isNewUser"
    
    private let advanceButtonStyling: OnboardViewController.ButtonStyling = { button in
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
// MARK: Public methods

    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: isNewUserKey)
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: isNewUserKey)
    }
    
    let pages: [OnboardPage] = [
        OnboardPage(title: "Add a record", imageName: "add", description: "Use plus button to create a new record you would like to track"),
        OnboardPage(title: "Delete a record", imageName: "swipe-left", description: "Swipe left on the record to delete it", advanceButtonTitle: "Get started!")
    ]
    
    func appearance() -> OnboardViewController.AppearanceConfiguration {
        return OnboardViewController.AppearanceConfiguration(tintColor: .black, backgroundColor: .systemOrange, imageContentMode: .scaleAspectFit, advanceButtonStyling: advanceButtonStyling)
    }
}
