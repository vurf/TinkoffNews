//
//  RequestFactory.swift
//  Tinkoff-News
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

struct RequestsFactory {
    
    struct ArticlesRequests {
        
        static func getArticleConfig(slug: String) -> RequestConfig<ArticleParser> {
            let request = ArticleRequest(slug: slug)
            return RequestConfig<ArticleParser>(request: request, parser: ArticleParser())
        }
        
        static func getArticlesConfig(pageOffset: Int, pageSize: Int) -> RequestConfig<ArticlesParser> {
            let request = ArticlesRequest(pageOffset: pageOffset, pageSize: pageSize)
            return RequestConfig<ArticlesParser>(request: request, parser: ArticlesParser())
        }
    }
}
