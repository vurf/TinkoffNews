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

class ArticleTableViewCell: UITableViewCell {
    
    static let key = "ArticleTableViewCell"
    
    @IBOutlet weak var titleArticleLabel: UILabel!
    @IBOutlet weak var detailArticleLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setConfiguration(config: Article) {
        self.titleArticleLabel.text = config.title
        self.detailArticleLabel.text = config.slug
        self.counterLabel.text = "1"
        self.counterLabel.layer.cornerRadius = 12
        self.counterLabel.layer.masksToBounds = true
    }
}

class ArticlesViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<Article>?
    var articlesDataProvider : ArticlesDataProvider?
    
    var saveContext: ISaveContext!
    var mainContext: IMainContext!
    var newsService: INewsService!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Новости"
        
        self.articlesDataProvider = ArticlesDataProvider(tableView: self.tableView, context: self.mainContext)
        self.fetchedResultsController = self.articlesDataProvider?.fetchedResultsController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do {
            try self.fetchedResultsController?.performFetch()
        } catch {
            // Ignore
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.newsService.getNews(from: 0, count: 20) { (result, error) in

            if let news = result {
                for article in news {
                    let art = Article.insert(in: self.saveContext.saveContext)
                    art?.id = article.id
                    art?.slug = article.slug
                    art?.title = article.title
                }
                
                self.saveContext.performSave(context: self.saveContext.saveContext, completionHandler: nil)
            }
        }
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
}
