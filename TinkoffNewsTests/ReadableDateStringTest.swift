//
//  ReadableDateStringTest.swift
//  TinkoffNewsTests
//
//  Created by Илья Варфоломеев on 01.07.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import XCTest
@testable import TinkoffNews

class ReadableDateStringTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessfulFormatReadableDateString() {
        
        // given
        let date = "2018-06-26T21:00:00.000Z"
        let expectedDate = "27 June, 00:00"
        
        // when
        let resultDate = date.getReadableDateString()
        
        // then
        XCTAssertEqual(expectedDate, resultDate)
    }
    
    func testBadFormatReadableDateString() {
        
        // given
        let date = "2018-06-26"
        
        // when
        let resultDate = date.getReadableDateString()
        
        // then
        XCTAssertEqual(date, resultDate)
    }
    
    func testBadFormatReadableString() {
        
        // given
        let date = "simple string"
        
        // when
        let resultDate = date.getReadableDateString()
        
        // then
        XCTAssertEqual(date, resultDate)
    }
}
