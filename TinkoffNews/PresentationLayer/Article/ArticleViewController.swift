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
    var newsService: INewsService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = article?.title
        self.headerLabel.text = article?.title
        self.createdTimeLabel.text = article?.createdTime
        self.contentTextView.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let slugUnwrapped = self.article?.slug else { return }
        self.newsService.getArticle(slug: slugUnwrapped) { (result, error) in
            DispatchQueue.main.async {
                self.contentTextView.attributedText = result?.text.convertHtml()
            }
        }
    }
}
