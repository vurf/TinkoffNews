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
    
    static func create(articleObject: Article) -> ArticleDisplayModel {
        let article = ArticleDisplayModel()
        article.id = articleObject.id
        article.title = articleObject.title
        article.createdTime = articleObject.createdTime
        article.slug = articleObject.slug
        
        return article
    }
}
