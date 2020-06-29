//
//  EveryThingService.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation


//MARK:- Responsbility : Acts as middle layer between network and view controllers. -

class EveryThingService {
    /// search about topic
    func search(Entry:String?,completion:@escaping(Result<ArticlesModel,APIError>)->()) {
        guard let Entry=Entry else {return}
        NetworkEngine.fetchData(serviceEndPoint: EveryThingEndPoint.getNewsByKeyword(keyword:Entry)) { ( result:Result<ArticlesModel,APIError> ) in
            completion(result)
        }
    }
 


}
