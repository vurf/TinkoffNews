//
//  ArticleTableViewCell.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 30.06.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
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
