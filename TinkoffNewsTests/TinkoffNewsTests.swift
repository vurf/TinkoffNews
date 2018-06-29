//
//  TinkoffNewsTests.swift
//  TinkoffNewsTests
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import XCTest
@testable import TinkoffNews

class TinkoffNewsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {        
//        XCTFail("kill")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let requestSender : IRequestSender = RequestSender()
            let newsConfig = RequestsFactory.ArticlesRequests.getArticlesConfig(pageOffset: 0, pageSize: 20)
            requestSender.send(requestConfig: newsConfig) { (result) in
                switch result {
                case .success(let news):
                    XCTAssertEqual(news.count, 20)
                    break
                    
                case .error(let error):
                    XCTFail(error)
                    break
                }
            }
        }
    }
    
}
