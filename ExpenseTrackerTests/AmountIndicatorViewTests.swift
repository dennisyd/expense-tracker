//
//  AmountIndicatorViewTests.swift
//  ExpenseTrackerTests
//
//  Created by Peter Alt on 4/5/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import XCTest

class AmountIndicatorViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testIndicatorGreenForAmountsLessThan25() {
        let view = AmountIndicatorView()
        view.setValue(value: 10)
        XCTAssertEqual(UIColor.green, view.backgroundColor)
        
        view.setValue(value: 0)
        XCTAssertEqual(UIColor.green, view.backgroundColor)
        
        view.setValue(value: 24.99)
        XCTAssertEqual(UIColor.green, view.backgroundColor)
        
        view.setValue(value: 25)
        XCTAssertNotEqual(UIColor.green, view.backgroundColor)
    }
    
    func testIndicatorOrangeForAmountsLessThan100() {
        let view = AmountIndicatorView()
        view.setValue(value: 25)
        XCTAssertEqual(UIColor.orange, view.backgroundColor)
        
        view.setValue(value: 99)
        XCTAssertEqual(UIColor.orange, view.backgroundColor)
        
        view.setValue(value: 99.99)
        XCTAssertEqual(UIColor.orange, view.backgroundColor)
        
        view.setValue(value: 100)
        XCTAssertNotEqual(UIColor.orange, view.backgroundColor)
    }
    
    func testIndicatorRedForAmountsGreaterThan100() {
        let view = AmountIndicatorView()
        view.setValue(value: 100)
        XCTAssertEqual(UIColor.red, view.backgroundColor)
        
        view.setValue(value: 1000)
        XCTAssertEqual(UIColor.red, view.backgroundColor)
    }
    
}
