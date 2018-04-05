//
//  ReceiptItem.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/4/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import Foundation

class ReceiptItem: Codable {
    var name: String
    var price: Double
    var EAN: String!
    
    var priceFormatted: String {
        get {
            return "$\(String(format: "%.2f", self.price))"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case price
        case EAN = "ean"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        if let asNumber = try? container.decode(Int64.self, forKey: .EAN) {
            EAN = String(asNumber)
        } else if let asString = try? container.decode(String.self, forKey: .EAN) {
            EAN = asString
        }
    }
}
