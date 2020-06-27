//
//  TopHeadLinesServices.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//
import Foundation

class TopHeadlineServices {
    
    // TODO:\   get all top headline by deafault
    class func topHeadlinesDeafault(country:String,completion:@escaping(Result<HeadlinesModel,APIError>)->Void) {
        NetworkEngine.fetchData(serviceEndPoint: TopHeadlinesEndPoint.getTopHeadlines(country: country)) { (result:Result<HeadlinesModel,APIError>) in
            completion(result)
        }
    }
    
    class func HeadlinesCategoryCountry(country:String,category:String,completion:@escaping(Result<HeadlinesModel,APIError>)->Void) {
        NetworkEngine.fetchData(serviceEndPoint: TopHeadlinesEndPoint.getByCategoryCountry(category: category, country: country)) { (result:Result<HeadlinesModel,APIError>) in
            completion(result)
        }
    }
    
}
