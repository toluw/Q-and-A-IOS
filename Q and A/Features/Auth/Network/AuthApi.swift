//
//  File.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation
import Moya


enum AuthAPI {
    case login(payload: LoginRequest)
    case forgotPassword(payload: ForgotPasswordRequest)
}


extension AuthAPI: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "v2/login3.php"
            
        case .forgotPassword(payload: let payload):
            return "v2/forgot_password.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            .post
        case .forgotPassword(payload: let payload):
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
           case .login(let payload):
            return .requestJSONEncodable(payload)
        case .forgotPassword(payload: let payload):
            return .requestJSONEncodable(payload)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
  
    
    
    
    
}
