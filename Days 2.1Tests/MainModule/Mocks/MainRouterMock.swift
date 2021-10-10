//
//  MainRouterMock.swift
//  Days 2.1Tests
//
//  Created by Олег Еременко on 10.10.2021.
//  Copyright © 2021 Oleg Eremenko. All rights reserved.
//

import UIKit
@testable import Days_2_1

final class MainRouterMock: MainRouterProtocol {
    var prepared = false

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepared.toggle()
    }
}
