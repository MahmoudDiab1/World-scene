//
//  EveryThingEndPoint.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation


//MARK:- Responsbility : NewsEndPoint responsible for configuring the request parts(scheme/base/path/parameter/method) of the request sent to the EveryThingEndPoint based on different cases. 2- filter response based on query parameter.-

var languagesDic = [
    "Portuguese": "pt", "Hebrew": "he", "Norwegisch": "no",
    "Arabic": "ar", "Northern Sami": "se", "Chinese": "zh",
    "English": "en", "Russian": "ru", "German": "de",
    "Italian": "it", "French": "fr", "Niederländisch": "nl"
]


enum EveryThingEndPoint:Endpoint {
    case  getNewsByKeyword (keyword: String)
    case getPreferedNews ( sources:[String]? , languages : [String]? , keywords:[String]? )
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
        case .getNewsByKeyword ,.getPreferedNews :
            return "/v2/everything"
        }
    }
    
    var parameter: [URLQueryItem] {
        switch self {
        case .getNewsByKeyword(let category):
            return [URLQueryItem(name: "apiKey", value:"1a779402052e4290838adc06ecd31d37"),
                    URLQueryItem(name: "q" ,value: category)]
        case .getPreferedNews(let sources ,let languages ,let keywords):
            var parameterList:[URLQueryItem]=[URLQueryItem(name: "apiKey", value:"1a779402052e4290838adc06ecd31d37")]
            if let sourcesList = sources {
                for i in 0..<sourcesList.count {
                    let value = sourcesList[i]
                    parameterList.append(URLQueryItem(name:"q",value:value))
                }
            }
            if let languagesList = languages {
                for i in 0..<languagesList.count {
                    let value = languagesList[i]
                    parameterList.append(URLQueryItem(name:"q",value:value))
                }
            }
            if let keywordsList = keywords {
                for i in 0..<keywordsList.count {
                    let value = keywordsList[i]
                    parameterList.append(URLQueryItem(name:"q",value:value))
                }
            }
            //            print("\(parameterList)")
            return parameterList
        }
    }
    var method: String {
        switch self {
        case .getNewsByKeyword,.getPreferedNews:
            return "GET"
            
        }
    }
    
    
}
