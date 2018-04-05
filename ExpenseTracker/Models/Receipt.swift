//
//  Receipt.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/4/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import Foundation

class Receipt: Codable {
    var shop: String
    var date: String
    var paid: Double
    var paymentType: String
    var items: [ReceiptItem]
    
    private enum CodingKeys: String, CodingKey {
        case shop
        case date
        case paid
        case paymentType = "payment_type"
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shop = try values.decode(String.self, forKey: .shop)
        date = try values.decode(String.self, forKey: .date)
        paid = try values.decode(Double.self, forKey: .paid)
        paymentType = try values.decode(String.self, forKey: .paymentType)
        items = try values.decode([ReceiptItem].self, forKey: .items)
    }
}
