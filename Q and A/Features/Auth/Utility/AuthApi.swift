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
}


extension AuthAPI: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "v2/login2.php"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
           case .login(let payload):
            return .requestJSONEncodable(payload)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
  
    
    
    
    
}
