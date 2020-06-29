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

//MARK:- Responsbility: Responsible for configuring HeadlineTableViewCell which used to populate 2 tables (Explore - Headlines)

class HeadlineTableViewCell: UITableViewCell {
    //    MARK:- outlets - 
    @IBOutlet var imageEffectView: UIView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var headlineTitle: UILabel!
    @IBOutlet weak var headlineImage: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    //    MARK:- Variables -
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var recievedBookMark:Article?
    var recievedHeadline:Headline?
    
    //    MARK:-LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)  {
        super.setSelected(selected, animated: animated)
        
    }
    
    //    MARK:- Actions
 
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
        favouriteButton.isHidden = true
        
        do {
            try  viewContext.save()
        } catch { fatalError(error.localizedDescription) }
        
    }
    
    func configureHeadlineCell(article : Headline?  )  {
        styleCell()
        guard let article = article else { return }
        self.recievedHeadline = article
        self.sourceName.text = article.source?.name
        self.author.text=article.author
        self.headlineTitle.text = article.title
        guard let urlString = article.urlToImage else { return }
        let url = URL(string: urlString)
        self.headlineImage.kf.setImage(with: url)
    }
    
    
    func configureBookMarkCell(article : Article?)  {
        styleCell()
        favouriteButton.isHidden = true
        guard let article = article else { return }
        self.recievedBookMark = article
        self.sourceName.text = article.sourceName
        self.author.text=article.authorName
        guard let urlString = article.urlToImage else { return }
        let url = URL(string: urlString)
        self.headlineImage.kf.setImage(with: url)
    }
    func styleCell () {
         self.headlineImage.layer.cornerRadius = 40
         self.headlineImage.layer.borderColor = UIColor.white.cgColor
         self.headlineImage.layer.borderWidth = 0.5
         self.layer.borderColor = UIColor.black.cgColor
         self.layer.borderWidth = 0.7
         self.layer.cornerRadius = 40
         self.clipsToBounds = true
        imageEffectView.layer.cornerRadius = 40
           
     }
}




