//
//  ArticleDisplayModel.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 30.06.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class ArticleDisplayModel {
    
    var id: String?
    var title: String?
    var text: String?
    var createdTime: String?
    var slug: String?
    var counter: Int?
    
    static func create(articleObject: Article) -> ArticleDisplayModel {
        let article = ArticleDisplayModel()
        article.id = articleObject.id
        article.title = articleObject.title
        article.createdTime = articleObject.createdTime
        article.slug = articleObject.slug
        article.counter = Int(articleObject.counter)
        article.text = articleObject.text
        
        return article
    }
    
    static func create(articleCore: ArticleCoreModel) -> ArticleDisplayModel {
        let article = ArticleDisplayModel()
        article.id = articleCore.id
        article.title = articleCore.title
        article.slug = articleCore.slug
        article.text = articleCore.text
        
        return article
    }
    
    static func create(shortArticleCore: ShortArticleCoreModel) -> ArticleDisplayModel {
        let article = ArticleDisplayModel()
        article.id = shortArticleCore.id
        article.title = shortArticleCore.title
        article.slug = shortArticleCore.slug
        article.createdTime = shortArticleCore.createdTime
        article.counter = Int(shortArticleCore.counter)
        
        return article
    }
}
