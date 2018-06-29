//
//  ArticleSenderTest.swift
//  TinkoffNewsTests
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import XCTest
@testable import TinkoffNews

class ArticleSenderTests: XCTestCase {
    
    var requestSender: IRequestSender!
    
    override func setUp() {
        super.setUp()
        self.requestSender = RequestSender()
    }
    
    override func tearDown() {
        self.requestSender = nil
        super.tearDown()
    }
    
    func testSendArticleBySlugConfig() {
        let expectation = self.expectation(description: "get article expectation")
        let expectedId = "bc8f9ad1-bb47-4c66-829a-350dd412e60d"
        let expectedTitle = "Программа лояльности Тинькофф Банка стала победителем премии Loyalty Awards Russia"
        let expectedSlug = "20062018-tinkoff-bank-x-loyalty-awards-russia"
        
        let newsConfig = RequestsFactory.ArticlesRequests.getArticleConfig(slug: "20062018-tinkoff-bank-x-loyalty-awards-russia")
        self.requestSender.send(requestConfig: newsConfig) { (result) in
            switch result {
            case .success(let article):
                XCTAssertEqual(expectedId, article.id)
                XCTAssertEqual(expectedTitle, article.title)
                XCTAssertEqual(expectedSlug, article.slug)
                XCTAssertTrue(article.text.hasPrefix("<p>Москва, Россия&nbsp;"))
                XCTAssertTrue(article.text.hasSuffix("Тинькофф Банка.</p>"))
                XCTAssertFalse(article.text.hasSuffix("123"))
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
