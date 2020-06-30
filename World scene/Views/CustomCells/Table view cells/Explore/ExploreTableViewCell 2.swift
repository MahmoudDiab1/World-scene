//
//  ExploreTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
  
    //    MARK:- Outlets
    @IBOutlet weak var moreDetailsButton: UIButton!
    @IBOutlet weak var sourceName: UILabel!
        @IBOutlet weak var authorName: UILabel!
        @IBOutlet weak var articleImage: UIImageView!
        @IBOutlet weak var articleContent: UITextView!
        @IBOutlet weak var backgroundCellView: UIView!
        @IBOutlet weak var articleTitle: UILabel!
    //    MARK:- Variabls
        
    //    MARK:- LifeCycle
        override func awakeFromNib() {
            super.awakeFromNib()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
        }
        
    //    MARK:- Functions 
      func  configureCell(with article : article?) {
            sourceName.text = article?.source?.name
            authorName.text = article?.author
            articleTitle.text = article?.title
            articleContent.text = article?.description
            guard let urlString = article?.urlToImage else { return }
                   let url = URL(string: urlString)
                  articleImage.kf.setImage(with: url)
            backgroundCellView.layer.cornerRadius = .pi
            articleImage.layer.cornerRadius = .pi
        }
        
    }

 
