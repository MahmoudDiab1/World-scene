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
    let source: headlineSource?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct headlineSource: Decodable {
    let id: String?
    let name: String?
}
