//
//  HomeTableVieeCell.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import Foundation
import UIKit


class HomeTableViewCell:UITableViewCell{
    
    
    @IBOutlet weak var poIdLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var itemsCountLabel: UILabel!
    
    override func prepareForReuse() {
        
    }
    
}
