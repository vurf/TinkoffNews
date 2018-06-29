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
                completionHandler(article, nil)
                
            case .error(let error):
                completionHandler(nil, error)
            }
        }
    }
}
