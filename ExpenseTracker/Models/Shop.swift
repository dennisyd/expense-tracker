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
    
    var paymentType: String {
        get {
            let cashPayments = receipts.filter({ $0.paymentType == "cash" })
            
            if cashPayments.count > 0 {
                return "cash"
            } else {
                return "card"
            }
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
    
    struct groupedItem {
        let name: String
        let amount: Double
        var amountFormatted: String {
            get {
                return "$\(String(format: "%.2f", self.amount))"
            }
        }
    }
    
    var groupedItems: [groupedItem] {
        get {
            // getting all receiptItems from all receipts
            let items = receipts.flatMap { $0.items }
            
            // mapping all receiptItems by item name
            let crossReferencedItems = items.reduce(into: [String: [ReceiptItem]]()) {
                $0[$1.name, default: []].append($1)
            }
            
            var itemCollection = [groupedItem]()
            
            for item in crossReferencedItems {
                let amounts = item.value.map { $0.price }
                let name = item.key + " (\(amounts.count)x)"
                let i = groupedItem(name: name, amount: amounts.reduce(0, {$0 + $1}))
                itemCollection.append(i)
            }
            return itemCollection
            
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
