//
//  Shop.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/4/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import Foundation

class Shop {
    private(set) var name: String
    private(set) var receipts = [Receipt]()
    
    var total: Double {
        get {
            let amounts = receipts.map { $0.paid }
            return amounts.reduce(0, {$0 + $1})
        }
    }
    
    var totalFormatted: String {
        get {
            return "$\(String(format: "%.2f", self.total))"
        }
    }
    
    var items: [ReceiptItem] {
        get {
            let items = receipts.flatMap { $0.items }
            return items
        }
    }
    
    init(name: String, receipt: Receipt) {
        self.receipts.append(receipt)
        self.name = name
    }
    
    func addReceipt(receipt: Receipt) {
        self.receipts.append(receipt)
    }
    
}
