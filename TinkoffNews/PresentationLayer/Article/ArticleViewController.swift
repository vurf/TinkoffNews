//
//  ArticleViewController.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/22/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    var article: ArticleDisplayModel?
    var articleModel: IArticleModel?
    var presentationAssembly: IPresentationAssembly?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = article?.title
        self.headerLabel.text = article?.title
        if let createdUnwrapped = article?.createdTime {
            self.createdTimeLabel.text = "Опубликовано: " + createdUnwrapped.getReadableDateString()
        }
        self.contentTextView.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let slugUnwrapped = self.article?.slug else { return }
        self.articleModel?.getArticle(slug: slugUnwrapped, completionHandler: { [weak self] (articleDisplayModel, error) in
            DispatchQueue.main.async {
                if let articleUnwrapped = articleDisplayModel {
                    self?.contentTextView.attributedText = articleUnwrapped.text?.convertHtml()
                } else if (error != nil) {
                    guard let networkAlertController = self?.presentationAssembly?.networkAlertController else {
                        return
                    }
                    
                    self?.present(networkAlertController, animated: true, completion: nil)
                    self?.contentTextView.text = networkAlertController.message
                }
            }
        })
    }
}
