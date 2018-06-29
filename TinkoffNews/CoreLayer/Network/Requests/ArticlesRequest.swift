//
//  ArticlesRequest.swift
//  Tinkoff-News
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class ArticlesRequest: IRequest {
    private let baseUrl: String = "https://cfg.tinkoff.ru/news/public/api/platform/v1/getArticles"
    private let pageOffset: Int
    private let pageSize: Int
    
    private var urlString: String {
        let params = "pageSize=\(self.pageSize)&pageOffset=\(self.pageOffset)"
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
    
    init(pageOffset: Int, pageSize: Int) {
        self.pageOffset = pageOffset
        self.pageSize = pageSize
    }
}
