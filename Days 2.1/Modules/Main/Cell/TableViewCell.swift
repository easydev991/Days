//
//  TableViewCell.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {

    // MARK: - Public properties
    
    static let cellID = "Cell"
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var itemNameLabel: UILabel! {
        didSet {
            itemNameLabel.numberOfLines             = 2
            itemNameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet private weak var itemDaysLabel: UILabel! {
        didSet {
            itemDaysLabel.numberOfLines             = 1
            itemDaysLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Public methods
    
    func setupCell(itemName: String, itemDays: String) {
        itemNameLabel.text = itemName
        itemDaysLabel.text = itemDays
    }

}
