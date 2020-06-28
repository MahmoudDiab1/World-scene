//
//  HeadlineTableViewCell.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class HeadlineTableViewCell: UITableViewCell {
        @IBOutlet var imageEffectView: UIView!
        @IBOutlet weak var author: UILabel!
        @IBOutlet weak var sourceName: UILabel!
        @IBOutlet weak var headlineTitle: UILabel!
        @IBOutlet weak var headlineImage: UIImageView!
        
    @IBOutlet weak var favouriteButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var recievedHeadline:Headline?
    override func awakeFromNib() {
            super.awakeFromNib()
        
    }
        override func setSelected(_ selected: Bool, animated: Bool)  {
            super.setSelected(selected, animated: animated)
            
        }
    
    @IBAction func favouritePressed(_ sender: UIButton) {
        
        let viewContext = appDelegate.persistentContainer.viewContext
        sender.isEnabled = false
        let article = Article(context: viewContext)
        article.authorName = recievedHeadline?.author
        article.articleContent = recievedHeadline?.content
        article.articleTitle = recievedHeadline?.title
        article.datePublished = recievedHeadline?.publishedAt
        article.sourceName = recievedHeadline?.source?.name
        article.sourceId = recievedHeadline?.source?.id
        article.urlToImage = recievedHeadline?.urlToImage
        article.articleDescription = recievedHeadline?.description
        do {
         try  viewContext.save()
        } catch { fatalError(error.localizedDescription) }
        
        }
    
    func configureCell(article : Headline? ,flage:Bool)  {
        if flage == false { favouriteButton.isHidden = true }
               guard let article = article else { return }
                 
            self.recievedHeadline = article
                      
            self.sourceName.text = article.source?.name
            self.author.text=article.author
            self.headlineTitle.text = article.title
            self.headlineImage.layer.cornerRadius = 40
            self.headlineImage.layer.borderColor = UIColor.white.cgColor
            self.headlineImage.layer.borderWidth = 0.5
                     self.layer.borderColor = UIColor.black.cgColor
                     self.layer.borderWidth = 0.7
                     self.layer.cornerRadius = 40
                     self.clipsToBounds = true
                     guard let urlString = article.urlToImage else { return }
                     let url = URL(string: urlString)
            self.headlineImage.kf.setImage(with: url)
                     print(article)
           
        
        }
    }


