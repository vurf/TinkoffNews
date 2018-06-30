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
        self.counterLabel.layer.cornerRadius = self.counterLabel.bounds.height / 2
        self.counterLabel.layer.masksToBounds = true
    }
    
    func setConfiguration(config: Article) {
        self.titleArticleLabel.text = config.title
        self.detailArticleLabel.text = config.createdTime
        self.counterLabel.text = String(config.counter)
    }
}

class ArticlesViewController: UITableViewController {
    
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
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Новости"
        
        if let mainContextUnwrapped = self.mainContext {
            self.articlesDataProvider = ArticlesDataProvider(tableView: self.tableView, context: mainContextUnwrapped)
            self.fetchedResultsController = self.articlesDataProvider?.fetchedResultsController
        } else {
            print("main context missing")
        }
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
        
        self.articlesModel?.fetchNews(from: 0, count: 20, completionHandler: { (result, error) in
            DispatchQueue.main.async {
                if error != nil, let networkAlertController = self.presentationAssemly?.networkAlertController {
                    self.present(networkAlertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        
        self.articlesModel?.fetchNews(from: 0, count: 20, completionHandler: { (result, error) in
            DispatchQueue.main.async {
                if error != nil, let networkAlertController = self.presentationAssemly?.networkAlertController {
                    self.present(networkAlertController, animated: true, completion: nil)
                }
                
                sender.endRefreshing()
            }
        })
    }
    
    // MARK: - Data Source
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
}
