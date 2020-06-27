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
        var article : Headline?
        @IBOutlet weak var articleContent: UITextView!
        @IBOutlet weak var sourceName: UILabel!
        @IBOutlet weak var articleTitle: UILabel!
        @IBOutlet weak var articleImage: UIImageView!
        
    //    var  article : Headline?
        override func viewWillAppear(_ animated: Bool) {
           guard let article = article else { return }
           articleContent.text = article.content
           sourceName?.text = article.source?.name
           articleTitle.text = article.title
           guard let urlString = article.urlToImage else { return }
           let url = URL(string: urlString)
           articleImage?.kf.setImage(with: url)
        }
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
    }
