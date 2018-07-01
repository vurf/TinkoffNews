//
//  NewsViewController.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/22/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ArticlesViewController: UITableViewController {
    
    let batchSize: Int = 20
    private var isDataLoading: Bool = false
    
    var fetchedResultsController: NSFetchedResultsController<Article>?
    var articlesDataProvider : ArticlesDataProvider?
    
    var mainContext: IMainContext?
    var presentationAssemly: IPresentationAssembly?
    var articlesModel: IArticlesModel?
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.tintColor = UIColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if let mainContextUnwrapped = self.mainContext {
            self.articlesDataProvider = ArticlesDataProvider(tableView: self.tableView, context: mainContextUnwrapped)
            self.fetchedResultsController = self.articlesDataProvider?.fetchedResultsController
        } else {
            print("main context missing")
        }
        
        self.performFetch()
        self.firstFetchNews()
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        // Условие: Жест pull-to-refresh приводит к обновлению списка новостей.
        // Непонятно, нужно ли удалять при этом кеш?! Если нужно, достаточно раскоментировать строку ниже, иначе оставить как есть.
        //self.articlesModel?.removeAllNews()
        self.fetchNews(from: 0, count: self.batchSize) {
            sender.endRefreshing()
        }
    }
    
    private func performFetch() {
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            // Ignore
        }
    }
    
    private func firstFetchNews() {
        guard let countFetchedObjects = self.fetchedResultsController?.fetchedObjects?.count, countFetchedObjects > 0 else {
            self.fetchNews(from: 0, count: self.batchSize, completionHandler: nil)
            return
        }
        
        self.fetchNews(from: 0, count: countFetchedObjects, completionHandler: nil)
    }
    
    private func fetchNews(from: Int, count: Int, completionHandler: (() -> ())?) {
        self.isDataLoading = true
        self.articlesModel?.fetchNews(from: from, count: count, completionHandler: { [weak self] (result, error) in
            DispatchQueue.main.async {
                if error != nil, let networkAlertController = self?.presentationAssemly?.networkAlertController {
                    if self?.presentedViewController == nil {
                        self?.present(networkAlertController, animated: true, completion: nil)
                    }
                }
                
                self?.isDataLoading = false
                completionHandler?()
            }
        })
    }
}

// MARK: - Data Source
extension ArticlesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articleViewController = self.presentationAssemly?.getArticleViewController() else { return }
        guard let articleObject = self.fetchedResultsController?.object(at: indexPath) else { return }
        
        self.articlesModel?.incrementCounter(article: articleObject)
        articleViewController.article = ArticleDisplayModel.create(articleObject: articleObject)
        self.navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowsCount = self.fetchedResultsController?.sections?[section].numberOfObjects {
            return rowsCount
        }
        
        return 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sectionsCount = self.fetchedResultsController?.sections?.count {
            return sectionsCount
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.key, for: indexPath) as! ArticleTableViewCell
        
        if let articleConfig = self.fetchedResultsController?.object(at: indexPath) {
            dequeuedCell.setConfiguration(config: articleConfig)
        }
        
        return dequeuedCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemPosition = self.tableView(tableView, numberOfRowsInSection: indexPath.section)
        if indexPath.row == lastItemPosition - 1, !self.isDataLoading {
            self.fetchNews(from: lastItemPosition, count: self.batchSize, completionHandler: nil)
        }
    }
}
