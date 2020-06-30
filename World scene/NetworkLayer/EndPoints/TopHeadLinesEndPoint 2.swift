//
//  TopHeadLinesEndPoint.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

//MARK:- Responsbility : 1- NewsEndPoint responsible for configuring the request parts(scheme/base/path/parameter/method) of the request sent  to the News API based on different cases.-
//MARK:- 2- filter response based on query parameter.-

enum TopHeadlinesEndPoint:Endpoint {
    case  getByCountry(country:String)
    case getByCategory (category:String )
}

extension TopHeadlinesEndPoint {
    var scheme:String  {
        switch self  {
        default:
            return "https"
        }
    }
    var base: String {
        switch self {
        default:
            return "newsapi.org"
        }
    }
    var path : String {
        switch self {
        case .getByCategory, .getByCountry:
            return "/v2/top-headlines"
        }
    }
    var parameter: [URLQueryItem] {
        switch self {
        case .getByCountry(country: let country):
            return [URLQueryItem(name: "country", value:country),
                    URLQueryItem(name: "apiKey", value:"1a779402052e4290838adc06ecd31d37")
                   ]
        case .getByCategory(let category):
            return [
                    URLQueryItem(name: "category", value:category),
                    URLQueryItem(name: "apiKey", value:"1a779402052e4290838adc06ecd31d37")
                   ]
        }
    }
    var method: String {
        switch self {
        case .getByCategory, .getByCountry:
            return "GET"
        }
    }
    
}
