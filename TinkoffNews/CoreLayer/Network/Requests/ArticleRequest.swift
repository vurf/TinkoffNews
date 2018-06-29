//
//  ArticleRequest.swift
//  Tinkoff-News
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

//https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle?slug=20062018-tinkoff-bank-x-loyalty-awards-russia

class ArticleRequest: IRequest {
    private let baseUrl: String = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticle"
    private let slug: String
    
    private var urlString: String {
        let params = "urlSlug=\(self.slug)"
        return self.baseUrl + "?" + params
    }
    
    var urlRequest: URLRequest? {
        get {
            
            if let url = URL(string: self.urlString) {
                return URLRequest(url: url)
            }
            
            return nil
        }
    }
    
    init(slug: String) {
        self.slug = slug
    }
}
