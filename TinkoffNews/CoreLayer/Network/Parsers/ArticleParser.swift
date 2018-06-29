//
//  ArticleParser.swift
//  Tinkoff-News
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class ArticleParser: IParser {
    typealias Model = ArticleModel
    
    func parse(data: Data) -> ArticleParser.Model? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
            
            guard let response = json["response"] as? [String:Any] else {
                return nil
            }
            
            guard let id = response["id"] as? String,
                let title = response["title"] as? String,
                let slug = response["slug"] as? String,
                let text = response["text"] as? String
            else {
                return nil
            }
            
            return ArticleModel(id: id, title: title, slug: slug, text: text)
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
