//
//  Articles.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

struct ArticlesModel:Decodable {
    var status: String?
    var articles: [article?]
}
struct article:Decodable {
    var source:ArticleSource?
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var puplishedAt:String?
    var content:String?
  
}
struct ArticleSource:Decodable {
    var id:String?
    var name:String?
    
}


 
