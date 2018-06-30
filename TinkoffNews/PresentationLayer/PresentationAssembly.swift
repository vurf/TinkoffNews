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
    
    var articleModel: IArticleModel {get}
    
    var articlesModel: IArticlesModel {get}
    
    var networkAlertController: UIAlertController {get}
    
    func getArticleViewController() -> ArticleViewController?
    
    func getRootViewController() -> UINavigationController?
}

class PresentationAssembly: IPresentationAssembly {
    
    private let serviceAssembly: IServicesAssembly
    
    init(serviceAssembly: IServicesAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    lazy var articleModel: IArticleModel = ArticleModel(newsService: self.serviceAssembly.newsService, mainContext: self.serviceAssembly.mainContext)
    
    lazy var articlesModel: IArticlesModel = ArticlesModel(newsService: self.serviceAssembly.newsService)
    
    lazy var networkAlertController: UIAlertController = {
        let alertController = UIAlertController(title: "Ошибка", message: "Интернет соединение отсутствует", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alertController
    }()
    
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
        articles.articlesModel = self.articlesModel
        
        navigation.viewControllers = [articles]
        
        return navigation
    }
    
    func getArticleViewController() -> ArticleViewController? {
        
        guard let articleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else {
            return nil
        }
        
        articleViewController.presentationAssembly = self
        articleViewController.articleModel = self.articleModel
        
        return articleViewController
    }
}
