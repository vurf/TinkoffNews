//
//  ArticleModel.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 30.06.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

protocol IArticleModel {
    
    func getArticle(slug: String, completionHandler: @escaping (ArticleDisplayModel?, String?) -> Void)
}

class ArticleModel: IArticleModel {
    
    private let newsService: INewsService
    private let context: IMainContext
    
    init(newsService: INewsService, mainContext: IMainContext) {
        self.newsService = newsService
        self.context = mainContext
    }
    
    func getArticle(slug: String, completionHandler: @escaping (ArticleDisplayModel?, String?) -> Void) {
        
        if let savedArticle = Article.getBySlug(in: self.context.mainContext, slug: slug), let _ = savedArticle.text {
            
            let article = ArticleDisplayModel.create(articleObject: savedArticle)
            completionHandler(article, nil)
            
        } else {
            self.newsService.getArticle(slug: slug) { (result, error) in
                if let articleCore = result {
                    
                    let article = ArticleDisplayModel.create(articleCore: articleCore)
                    completionHandler(article, nil)
                    
                } else if error != nil {
                    completionHandler(nil, error)
                }
            }
        }
    }
}
