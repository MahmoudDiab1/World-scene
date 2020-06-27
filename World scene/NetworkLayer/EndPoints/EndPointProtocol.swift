//
//  EndPointProtocole.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

protocol Endpoint {
    var scheme: String {get}
    var base: String {get}
    var path: String {get}
    var parameter: [ URLQueryItem ] {get}
    var method : String {get}
}
