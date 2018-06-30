//
//  NewsService.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/27/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import CoreData

protocol INewsService {
    
    func getNews(from: Int, count: Int, completionHandler: @escaping ([ShortArticleModel]?, String?) -> Void)
    
    func getArticle(slug: String, completionHandler: @escaping (ArticleModel?, String?) -> Void)
}

class NewsService: INewsService {
    
    private let requestSender: IRequestSender
    private let context: ISaveContext
    
    init(requestSender: IRequestSender, context: ISaveContext) {
        self.requestSender = requestSender
        self.context = context
    }
    
    func getNews(from: Int, count: Int, completionHandler: @escaping ([ShortArticleModel]?, String?) -> Void) {
        
        let newsConfig = RequestsFactory.ArticlesRequests.getArticlesConfig(pageOffset: from, pageSize: count)
        
        self.requestSender.send(requestConfig: newsConfig) { (result) in
            switch result {
            case .success(let articles):
                
                for article in articles {
                    
                    if Article.getById(in: self.context.saveContext, id: article.id) != nil {
                        continue
                    }
                    
                    let articleObject = Article.insert(in: self.context.saveContext)
                    articleObject?.id = article.id
                    articleObject?.slug = article.slug
                    articleObject?.title = article.title
                    articleObject?.createdTime = article.createdTime
                }

                self.context.performSave(context: self.context.saveContext, completionHandler: nil)
                completionHandler(articles, nil)
                
            case .error(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func getArticle(slug: String, completionHandler: @escaping (ArticleModel?, String?) -> Void) {
        
        let articleConfig = RequestsFactory.ArticlesRequests.getArticleConfig(slug: slug)
        
        self.requestSender.send(requestConfig: articleConfig) { (result) in
            switch result {
            case .success(let article):
                
                if let savedArticle = Article.getById(in: self.context.saveContext, id: article.id) {
                    savedArticle.text = article.text
                }
                
                self.context.performSave(context: self.context.saveContext, completionHandler: nil)
                completionHandler(article, nil)
                
            case .error(let error):
                completionHandler(nil, error)
            }
        }
    }
}
