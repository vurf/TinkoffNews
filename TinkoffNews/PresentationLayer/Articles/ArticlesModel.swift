//
//  ArticlesModel.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 30.06.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

protocol IArticlesModel {
    
    func incrementCounter(article: Article)
    
    func fetchNews(from: Int, count: Int, completionHandler: @escaping ([ArticleDisplayModel]?, String?) -> Void)
}

class ArticlesModel: IArticlesModel {
    
    private let newsService: INewsService
    
    init(newsService: INewsService) {
        self.newsService = newsService
    }
    
    func incrementCounter(article: Article) {
        
        guard let idUnwrapped = article.id else { return }
        
        self.newsService.incrementCounter(id: idUnwrapped)
    }
    
    func fetchNews(from: Int, count: Int, completionHandler: @escaping ([ArticleDisplayModel]?, String?) -> Void) {
        
        self.newsService.getNews(from: from, count: count) { (result, error) in
            if let resultUnwrapped = result {
                
                let articlesDisplay = resultUnwrapped.map({ (article) -> ArticleDisplayModel in
                    return ArticleDisplayModel.create(shortArticleCore: article)
                })
                
                completionHandler(articlesDisplay, nil)
            } else if error != nil {
                completionHandler(nil, error)
            }
        }
    }
}
