//
//  MainPresenter.swift
//  Days 2.1
//
//  Created by Олег Еременко on 11.07.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import Foundation
import RealmSwift

final class MainPresenter: MainPresenterProtocol {  

// MARK: Public properties
    
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    
// MARK: Protocol properties
    
    let realm = try! Realm()
    var router: MainRouterProtocol!
    var items: Results<Item>?
    
// MARK: Init
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
// MARK: Protocol methods
    
    func configureView() {
        interactor.loadItems()
    }
    
    func addItem(with title: String){
        interactor.addItem(with: title)
    }
    
    func reloadTVData() {
        view.reloadTableViewData()
    }
    
    func removeItem(item: Item){
        interactor.removeItem(item: item)
    }
    
    func saveItem(item: Item){
        interactor.saveItem(item: item)
    }
    
    func dateToTextDays(item: Item) -> String{
        return interactor.dateToTextDays(item: item)
    }
    
    func addButtonClicked(){
        router.showItemScene()
    }

}
