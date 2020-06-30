//
//  Sources.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

struct SourcesModle:Decodable {
    let status: String
    let sources: [Source]
}

struct Source:Decodable {
    let id, name, sourceDescription: String
    let url: String
    let category, language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}
