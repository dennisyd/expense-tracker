//
//  ItemCell.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/5/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    weak var item: ReceiptItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func format(item: ReceiptItem) {
        self.item = item;
        title.text = item.name
        amount.text = item.priceFormatted
    }
    
}