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
    
    func removeAllNews()
    
    func fetchNews(from: Int, count: Int, completionHandler: @escaping ([ArticleDisplayModel]?, String?) -> Void)
}

class ArticlesModel: IArticlesModel {
    
    private let newsService: INewsService
    private let coreDataService: ICoreDataService
    
    init(newsService: INewsService, coreDataService: ICoreDataService) {
        self.newsService = newsService
        self.coreDataService = coreDataService
    }
    
    func incrementCounter(article: Article) {
        
        guard let idUnwrapped = article.id else { return }
        
        self.coreDataService.incrementCounter(id: idUnwrapped)
    }
    
    func removeAllNews() {
        
        self.coreDataService.removeAllArticles()
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
