//
//  ResultType.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation


//MARK:-Responsbility : to capture data  or error in generic way that helps to use any custom data model during decoding and custom Error type.-

enum Result<T,U> where U:Error {
    case success (T)
    case failure (U)
}
