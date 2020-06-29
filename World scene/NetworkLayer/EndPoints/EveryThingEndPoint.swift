//
//  EveryThingEndPoint.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation


//MARK:- Responsbility : NewsEndPoint responsible for configuring the request parts(scheme/base/path/parameter/method) of the request sent to the EveryThingEndPoint based on different cases.  -
//MARK:- 2- filter response based on query parameter.   -

enum EveryThingEndPoint:Endpoint {
    
    case  getNewsByKeyword (keyword: String)
}

extension  EveryThingEndPoint {
    var scheme:String {
        switch self {
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
        case .getNewsByKeyword  :
            return "/v2/everything"
        }
    }
    var parameter: [URLQueryItem] {
        switch self {
        case .getNewsByKeyword(let category):
            return [URLQueryItem(name: "apiKey", value:"1a779402052e4290838adc06ecd31d37"),
                    URLQueryItem(name: "q" ,value: category)]
        }
    }
    var method: String {
        switch self {
        case .getNewsByKeyword :
            return "GET"
            
        }
    }
    
    
}

