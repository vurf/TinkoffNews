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
    
    static let key = "articleTableViewCell"
    
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
        let backgroundSelectedView = UIView(frame: CGRect.zero)
        backgroundSelectedView.backgroundColor = UIColor(red: 255/255, green: 237/255, blue: 148/255, alpha: 160/255)
        self.selectedBackgroundView = backgroundSelectedView
    }
    
    func setConfiguration(config: Article) {
        self.titleArticleLabel.text = config.title
        self.detailArticleLabel.text = config.createdTime?.getReadableDateString()
        self.counterLabel.text = String(config.counter)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.counterLabel.backgroundColor
        super.setSelected(selected, animated: animated)
        self.counterLabel.backgroundColor = color
    }
 
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = self.counterLabel.backgroundColor;
        super.setHighlighted(highlighted, animated: animated)
        self.counterLabel.backgroundColor = color;
    }
}
