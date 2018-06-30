//
//  PresentationAssembly.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/22/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import UIKit

protocol IPresentationAssembly {
    
    func getArticleViewController() -> ArticleViewController?
    
    func getRootViewController() -> UINavigationController?
}

class PresentationAssembly: IPresentationAssembly {
    
    private let serviceAssembly: IServicesAssembly
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func getRootViewController() -> UINavigationController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let navigation = storyboard.instantiateInitialViewController() as? UINavigationController else {
            return nil
        }
        
        guard let articles = storyboard.instantiateViewController(withIdentifier: "ArticlesViewController") as? ArticlesViewController else {
            return nil
        }
        
        articles.presentationAssemly = self
        articles.mainContext = self.serviceAssembly.mainContext
        articles.newsService = self.serviceAssembly.newsService
        
        navigation.viewControllers = [articles]
        
        return navigation
    }
    
    func getArticleViewController() -> ArticleViewController? {
        
        guard let articleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else {
            return nil
        }
        
        articleViewController.newsService = self.serviceAssembly.newsService
        
        return articleViewController
    }
    
    func getArticlesViewController() -> ArticlesViewController? {
        
        guard let articlesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticlesViewController") as? ArticlesViewController else {
            return nil
        }
        
        //        articlesViewController.mainContext =
        
        return articlesViewController
    }
}
