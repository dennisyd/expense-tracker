//
//  ReceiptStore.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/4/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import Foundation

class Store {
    
    private(set) var receipts = [Receipt]()
    private(set) var shops = [Shop]()
    
    init() {
    }
    
    func process(data: Data) {
        do {
            receipts = try JSONDecoder().decode([Receipt].self, from: data)
            
            for receipt in receipts {
                if let shopIndex = shops.index(where: { $0.name == receipt.shop }) {
                    shops[shopIndex].addReceipt(receipt: receipt)
                } else {
                    let shop = Shop(name: receipt.shop, receipt: receipt)
                    shops.append(shop)
                }
            }
        } catch {
            print("caught: \(error)")
        }
    }
}
