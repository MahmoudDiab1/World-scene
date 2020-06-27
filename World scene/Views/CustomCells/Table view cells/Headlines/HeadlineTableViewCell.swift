//
//  HeadlineTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Kingfisher

class HeadlineTableViewCell: UITableViewCell {
        @IBOutlet var imageEffectView: UIView!
        @IBOutlet weak var author: UILabel!
        @IBOutlet weak var sourceName: UILabel!
        @IBOutlet weak var headlineTitle: UILabel!
        @IBOutlet weak var headlineImage: UIImageView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        override func setSelected(_ selected: Bool, animated: Bool)  {
            super.setSelected(selected, animated: animated)
            
        }
        func configureCell(article : Headline?)  {
            guard let article = article else { return }
            sourceName.text=article.source?.name
            author.text=article.author
            headlineTitle.text = article.title
            headlineImage.layer.cornerRadius = 40
            headlineImage.layer.borderColor = UIColor.white.cgColor
            headlineImage.layer.borderWidth = 0.5
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 0.7
            self.layer.cornerRadius = 40
            self.clipsToBounds = true
            guard let urlString = article.urlToImage else { return }
            
            let url = URL(string: urlString)
            headlineImage.kf.setImage(with: url)
            print(article)
        }
    }


