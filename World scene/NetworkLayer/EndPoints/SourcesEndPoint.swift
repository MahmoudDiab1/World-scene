//
//  SourcesEndPoint.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation


//MARK:- Responsbility: 1- NewsEndPoint responsible for configuring the request parts(scheme/base/path/parameter/method) of the request sent  to the News API based on different cases. 2- filter response based on query parameter.-

enum SourcesEndPoint:Endpoint {
    case getsources
}
extension SourcesEndPoint {
    var scheme:String  {
        switch self {
        default:
            return "https"
        }
    }
    var base: String {
        switch self{
        default:
            return "newsapi.org"
        }
    }
    var path : String {
        switch self {
        case .getsources:
            return "/v2/sources"
        }
    }
    var parameter: [URLQueryItem] {
        switch self {
        case .getsources:
            return  [URLQueryItem(name: "apiKey", value:"1a779402052e4290838adc06ecd31d37")]
        }
    }
    var method: String {
        switch self {
        case .getsources:
            return "GET"
        }
    }
}
