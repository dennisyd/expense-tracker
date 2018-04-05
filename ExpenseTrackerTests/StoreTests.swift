//
//  ReceiptStoreTests.swift
//  ExpenseTrackerTests
//
//  Created by Peter Alt on 4/4/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import XCTest

class StoreTests: XCTestCase {
    var receiptSampleJSON : String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        receiptSampleJSON = """
            [
            {
            "date": "2018-01-09T07:33:17.339",
            "shop": "Che DrÃ©",
            "paid": 20.099999999999998,
            "payment_type": "card",
            "items": [
            {
            "name": "Flat White",
            "price": 4.1,
            "ean": 4252308640648
            },
            {
            "name": "Long Black",
            "price": 3.8,
            "ean": 9124964074592
            },
            {
            "name": "Long Black",
            "price": 3.8,
            "ean": 9124964074592
            },
            {
            "name": "Almond Croissant",
            "price": 4.2,
            "ean": 6518346837654
            },
            {
            "name": "Almond Croissant",
            "price": 4.2,
            "ean": 6518346837654
            }
            ]
            },
            {
            "date": "2018-02-18T08:54:47.514",
            "shop": "Love & Nourish",
            "paid": 21.7,
            "payment_type": "card",
            "items": [
            {
            "name": "Cappuccino",
            "price": 3.8,
            "ean": 2557775661526
            },
            {
            "name": "Flat White",
            "price": 4.1,
            "ean": 4252308640648
            },
            {
            "name": "Flat White",
            "price": 4.1,
            "ean": 4252308640648
            },
            {
            "name": "Pain Au Chocolat",
            "price": 5.5,
            "ean": 3436137903582
            },
            {
            "name": "Almond Croissant",
            "price": 4.2,
            "ean": 6518346837654
            }
            ]
            },
            {
            "date": "2018-03-08T08:56:34.995",
            "shop": "Love & Nourish",
            "paid": 19.8,
            "payment_type": "card",
            "items": [
            {
            "name": "Cappuccino",
            "price": 3.8,
            "ean": 2557775661526
            },
            {
            "name": "Long Black",
            "price": 3.8,
            "ean": 9124964074592
            },
            {
            "name": "Long Black",
            "price": 3.8,
            "ean": 9124964074592
            },
            {
            "name": "ANZAC Biscuit",
            "price": 2.1,
            "ean": 4719853100008
            },
            {
            "name": "Almond Croissant",
            "price": 4.2,
            "ean": 6518346837654
            },
            {
            "name": "ANZAC Biscuit",
            "price": 2.1,
            "ean": 4719853100008
            }
            ]
            }]
        """
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testHasReceipts() {
        let store = Store()
        store.process(data: receiptSampleJSON.data(using: .utf8)!)
        XCTAssertEqual(3, store.receipts.count)
    }
    
    func testHasShops() {
        let store = Store()
        store.process(data: receiptSampleJSON.data(using: .utf8)!)
        XCTAssertEqual(2, store.shops.count)
    }
    
    func testGetTotalForShop() {
        let store = Store()
        store.process(data: receiptSampleJSON.data(using: .utf8)!)
        
        if let storeCheIndex = store.shops.index(where: { $0.name == "Che DrÃ©" }) {
            XCTAssertEqual(20.099999999999998,  store.shops[storeCheIndex].total)
        } else {
            XCTFail()
        }
        
        if let storeLnNIndex = store.shops.index(where: { $0.name == "Love & Nourish" }) {
            XCTAssertEqual(41.5,  store.shops[storeLnNIndex].total)
        } else {
            XCTFail()
        }
    }
    
    func testGetListItemsWithPriceForShop() {
        let store = Store()
        store.process(data: receiptSampleJSON.data(using: .utf8)!)
        
        if let storeLnNIndex = store.shops.index(where: { $0.name == "Love & Nourish" }) {
            XCTAssertEqual(11,  store.shops[storeLnNIndex].items.count)
        } else {
            XCTFail()
        }
    }
    
    func testDownloadFile() {
        let sourceURL = URL(string: "https://api.tabletcommand.com/interview/groceries.json")!
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(sourceURL.lastPathComponent)
        
        try? FileManager().removeItem(atPath: destinationUrl.path)
        
        XCTAssertFalse(FileManager().fileExists(atPath: destinationUrl.path))
        
        let expectation = XCTestExpectation(description: "Download data from server")
        
        let store = Store()
        store.download(completion: { path, error in
            XCTAssertNotNil(path)
            XCTAssertNil(error)
            
            XCTAssertTrue(FileManager().fileExists(atPath: destinationUrl.path))
            XCTAssertTrue(FileManager().fileExists(atPath: path!))
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testUpdateStore() {
        let store = Store()
        XCTAssertEqual(0, store.receipts.count)
        let expectation = XCTestExpectation(description: "Download data from server")
        
        store.update(completion: { error in
            XCTAssertNil(error)
            XCTAssertEqual(8, store.receipts.count)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
    }
    
}
