//
//  ArticlesParser.swift
//  Tinkoff-News
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class ArticlesParser: IParser {
    typealias Model = [ShortArticleModel]
    
    func parse(data: Data) -> ArticlesParser.Model? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
            
            guard let response = json["response"] as? [String:Any],
                let news = response["news"] as? [[String: Any]]
            else {
                return nil
            }
            
            var articles: [ShortArticleModel] = []
            
            for shortArticle in news {
                guard let id = shortArticle["id"] as? String,
                    let title = shortArticle["title"] as? String,
                    let slug = shortArticle["slug"] as? String
                else {
                        continue
                }
                
                articles.append(ShortArticleModel(id: id, title: title, slug: slug, counter: 0))
            }
            
            return articles
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
