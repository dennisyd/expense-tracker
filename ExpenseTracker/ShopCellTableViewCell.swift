//
//  ShopCellTableViewCell.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/5/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import UIKit

class ShopCellTableViewCell: UITableViewCell {

    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopTotalLabel: UILabel!
    
    weak var shop: Shop!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func format(shop: Shop) {
        self.shop = shop;
        shopNameLabel.text = shop.name
        shopTotalLabel.text = "$\(String(format: "%.2f", shop.total))"
    }

}
