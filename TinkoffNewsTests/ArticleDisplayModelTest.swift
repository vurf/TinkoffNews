//
//  ArticleDisplayModelTest.swift
//  TinkoffNewsTests
//
//  Created by Илья Варфоломеев on 01.07.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import XCTest
@testable import TinkoffNews

class ArticleDisplayModelTest: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.coreDataStack = CoreDataStack()
    }
    
    override func tearDown() {
        self.coreDataStack = nil
        super.tearDown()
    }
    
    func testCreateFromArticleObject() {
        
        // given
        let expectedArticle = Article(context: self.coreDataStack.saveContext)
        expectedArticle.id = "9874bb19-0fa5-4cc5-a5cf-ba6c7eb39b50"
        expectedArticle.slug = "slug-example"
        expectedArticle.counter = 2
        expectedArticle.createdTime = "2018-02-20T20:02:21.000Z"
        expectedArticle.title = "expected title"
        expectedArticle.text = "expected text"
        
        // when
        let resultArticle = ArticleDisplayModel.create(articleObject: expectedArticle)
    
        // then
        XCTAssertEqual(expectedArticle.id, resultArticle.id)
        XCTAssertEqual(expectedArticle.slug, resultArticle.slug)
        XCTAssertEqual(Int(expectedArticle.counter), resultArticle.counter)
        XCTAssertEqual(expectedArticle.createdTime, resultArticle.createdTime)
        XCTAssertEqual(expectedArticle.title, resultArticle.title)
        XCTAssertEqual(expectedArticle.text, resultArticle.text)
    }
    
    func testCreateFromArticleCore() {
        
        // given
        let expectedArticle = ArticleCoreModel(id: "9874bb19-0fa5-4cc5-a5cf-ba6c7eb39b50", title: "expected title", slug: "slug-example", text: "expected text")
        
        // when
        let resultArticle = ArticleDisplayModel.create(articleCore: expectedArticle)
        
        // then
        XCTAssertEqual(expectedArticle.id, resultArticle.id)
        XCTAssertEqual(expectedArticle.slug, resultArticle.slug)
        XCTAssertEqual(expectedArticle.title, resultArticle.title)
        XCTAssertEqual(expectedArticle.text, resultArticle.text)
        
        XCTAssertNil(resultArticle.counter)
        XCTAssertNil(resultArticle.createdTime)
    }
    
    func testCreateFromShortArticleCore() {
        
        // given
        let expectedArticle = ShortArticleCoreModel(id: "9874bb19-0fa5-4cc5-a5cf-ba6c7eb39b50", title: "expected title", slug: "slug-example", counter: 2, createdTime: "2018-06-26T21:00:00.000Z")
        
        // when
        let resultArticle = ArticleDisplayModel.create(shortArticleCore: expectedArticle)
        
        // then
        XCTAssertEqual(expectedArticle.id, resultArticle.id)
        XCTAssertEqual(expectedArticle.slug, resultArticle.slug)
        XCTAssertEqual(expectedArticle.title, resultArticle.title)
        XCTAssertEqual(Int(expectedArticle.counter), resultArticle.counter)
        XCTAssertEqual(expectedArticle.createdTime, resultArticle.createdTime)
        
        XCTAssertNil(resultArticle.text)
    }
}
