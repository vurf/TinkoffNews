//
//  CoreDataService.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 01.07.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

protocol ICoreDataService {
    
    func incrementCounter(id: String)
    
    func removeAllArticles()
}

class CoreDataService: ICoreDataService {
    
    private let context: ISaveContext
    
    init(context: ISaveContext) {
        self.context = context
    }
    
    func incrementCounter(id: String) {
        
        guard let savedArticle = Article.getById(in: self.context.saveContext, id: id) else {
            return
        }
        
        savedArticle.counter = savedArticle.counter + 1
        self.context.performSave(context: self.context.saveContext, completionHandler: nil)
    }
    
    func removeAllArticles() {
        Article.deleteAll(in: self.context.saveContext)
    }
}
