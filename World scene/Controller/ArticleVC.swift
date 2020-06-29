//
//  ArticleVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleVC: UIViewController {
//    MARK:- Variables -
    var headline : Headline?
    var Bookmark :Article?
    var article:article?
    var articleType :String?
    var articleUrl:String?
    
//    MARK:-Outlets-
    @IBOutlet weak var articleContent: UITextView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var gotoSourceTapped: UIButton!
//    MARK:- LifeCycle -
    override func viewWillAppear(_ animated: Bool) {
         
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        switch articleType
        {
        case "Headline":
            guard let headlinArticle  = headline else { return }
            articleUrl = headlinArticle.url
            articleContent.text =  headlinArticle.content
            sourceName?.text = headlinArticle.source?.name
            articleTitle.text = headlinArticle.title
            guard let urlString = headlinArticle.urlToImage else { return }
            let url = URL(string: urlString)
            articleImage?.kf.setImage(with: url)
        case "Article" :
            guard let Bookmark = Bookmark else { return }
            articleUrl = Bookmark.articleUrl
            articleContent.text = Bookmark.articleContent
            sourceName?.text = Bookmark.sourceName
            articleTitle.text = Bookmark.articleTitle
            guard let urlBookmarkString = Bookmark.urlToImage else { return }
            let urlToImage = URL(string: urlBookmarkString)
            articleImage?.kf.setImage(with: urlToImage)
        case "article":
            guard let fullArticle = article else { return }
            articleUrl = fullArticle.url
            articleContent.text = fullArticle.content
            sourceName?.text = fullArticle.source?.name
            articleTitle.text = fullArticle.title
            guard let urlString = fullArticle.urlToImage else { return }
            let url = URL(string: urlString)
            articleImage?.kf.setImage(with: url)
        default :
            break
        } 
    }
    
//    MARK:-Actions-
    @IBAction func gotoSource(_ sender: Any) {
        guard let url = articleUrl else {
            sourceName.text = " No source available for thic article. " ; return
        }
        if let link = URL(string: url) {
          UIApplication.shared.open(link)
        }
    }
}
