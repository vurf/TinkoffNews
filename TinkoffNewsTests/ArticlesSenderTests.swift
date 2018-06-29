//
//  ArticlesSenderTests.swift
//  TinkoffNewsTests
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import XCTest
@testable import TinkoffNews

class ArticlesSenderTests: XCTestCase {
    
    var requestSender: IRequestSender!
    
    override func setUp() {
        super.setUp()
        self.requestSender = RequestSender()
    }
    
    override func tearDown() {
        self.requestSender = nil
        super.tearDown()
    }
    
    func testSend20ArticlesConfig() {
        let expectation = self.expectation(description: "get 20 articles expectation")
        let expectedCount = 20
        
        let newsConfig = RequestsFactory.ArticlesRequests.getArticlesConfig(pageOffset: 0, pageSize: expectedCount)
        self.requestSender.send(requestConfig: newsConfig) { (result) in
            switch result {
            case .success(let news):
                XCTAssertEqual(expectedCount, news.count)
                
                for article in news {
                    XCTAssertFalse(article.id.isEmpty)
                    XCTAssertFalse(article.slug.isEmpty)
                    XCTAssertFalse(article.title.isEmpty)
                }
                
                break
                
            case .error(let error):
                XCTFail(error)
                break
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }    
}
