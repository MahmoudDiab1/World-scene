//
//  Headlines.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

struct HeadlinesModel: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Headline]?
}

struct Headline: Decodable {
    var source: headlineSource?
    var author, title, description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct headlineSource: Decodable {
    var id: String?
    var name: String?
}
