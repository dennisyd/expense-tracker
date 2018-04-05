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
    var EAN: Int64
    
    private enum CodingKeys: String, CodingKey {
        case name
        case price
        case EAN = "ean"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.EAN = try container.decode(Int64.self, forKey: .EAN)
    }
}
