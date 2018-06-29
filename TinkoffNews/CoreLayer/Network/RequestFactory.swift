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
        
//        static func photoYellowFlowersConfig() -> RequestConfig<PhotoParser> {
//            let request = PhotoRequest(apiKey: "8868552-d296293bdcb4bdca2ba7fa783")
//            return RequestConfig<PhotoParser>(request:request, parser: PhotoParser())
//        }
//
//        static func generateImageConfig(urlString: String) -> RequestConfig<ImageParser> {
//            let request = ImageRequest(urlString: urlString)
//            return RequestConfig<ImageParser>(request: request, parser: ImageParser())
//        }
    }
}
