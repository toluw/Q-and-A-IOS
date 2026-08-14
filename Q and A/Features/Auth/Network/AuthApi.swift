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
    case changePassword(payload: ChangePasswordRequest)
    case socialLogin(payload: SocialLoginBody)
    case socialSignUp(payload: SocialSignupBody)
}


extension AuthAPI: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "v2/login3.php"
            
        case .forgotPassword:
            return "v2/forgot_password.php"
        case .changePassword:
            return "v2/change_password.php"
        case .socialLogin:
            return "v2/check_register_ios.php"
        case .socialSignUp:
            return "v2/login_confirmation_ios.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            .post
        case .forgotPassword:
            .post
        case .changePassword:
            .post
        case .socialLogin:
            .post
        case .socialSignUp:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
           case .login(let payload):
            return .requestJSONEncodable(payload)
        case .forgotPassword(payload: let payload):
            return .requestJSONEncodable(payload)
        case .changePassword(payload: let payload):
            return .requestJSONEncodable(payload)
        case .socialLogin(payload: let payload):
            return   .requestJSONEncodable(payload)
        case .socialSignUp(payload: let payload):
            return   .requestJSONEncodable(payload)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
  
    
    
    
    
}
