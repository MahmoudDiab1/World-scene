//
//  ForYouTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit

class ForYouTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
