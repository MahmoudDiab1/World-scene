//
//  TagsTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class TagsTableViewCell: UITableViewCell {
    
        @IBOutlet weak var categoryLbl: UILabel!
        @IBOutlet weak var imageEffectView: UIView!
        @IBOutlet weak var topicDescription: UILabel!
        @IBOutlet weak var topicTitle: UILabel!
        @IBOutlet weak var topicImage: UIImageView!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        func configureCell (with topic : article)
        {
            topicDescription.text = topic.description
            topicTitle.text = topic.title
            
            
            guard let urlString = topic.urlToImage else { return }
                   let url = URL(string: urlString)
                   topicImage.kf.setImage(with: url)
        }
    }
