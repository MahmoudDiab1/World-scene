//
//  AuthenticationError.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import Foundation

enum SignupError:String {
    case emptyField
    case existedUser
    case notMatchedPasswords
    case invalidePassword
    var errorDescription:String{
    switch self {
    case .emptyField:
        return " please fill all data fieldes "
    case .existedUser:
        return "Invalide email or user already existed please use another email or login if you have that mail"
    case .notMatchedPasswords:
        return "not matched entered passwords,enter an identical passwords"
    case .invalidePassword:
        return " password is too short.make it more than 6 letters "
    }
  }
}

enum SigninError:String {
    case emptyField
    case failedSignIn
    var errorDescription:String {
        switch self {
        case .emptyField:
            return " please fill all data fieldes "
        case  .failedSignIn:
            return " failed to sign in "
        }
    }
}
