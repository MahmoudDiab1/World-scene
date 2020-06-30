//
//  TopHeadLinesServices.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//
import Foundation

class TopHeadlineServices {
    
    class func headlinesByCountry(country:String,completion:@escaping(Result<HeadlinesModel,APIError>)->Void) {
        NetworkEngine.fetchData(serviceEndPoint: TopHeadlinesEndPoint.getByCountry(country: country)) { (result:Result<HeadlinesModel,APIError>) in
            completion(result)
        }
    }
    
    class func headlinesByCountryCategory(category:String,completion:@escaping(Result<HeadlinesModel,APIError>)->Void) {
        NetworkEngine.fetchData(serviceEndPoint: TopHeadlinesEndPoint.getByCategory(category: category)){ (result:Result<HeadlinesModel,APIError>) in
            completion(result)
        }
    }
}

