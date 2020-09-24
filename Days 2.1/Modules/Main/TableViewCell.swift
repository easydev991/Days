//
//  TableViewCell.swift
//  Days 2.1
//
//  Created by Олег Еременко on 28.06.2020.
//  Copyright © 2020 Oleg Eremenko. All rights reserved.
//

import UIKit

final class TableViewCell: UITableViewCell {

// MARK: IBOutlets
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDaysLabel: UILabel!
    
// MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
