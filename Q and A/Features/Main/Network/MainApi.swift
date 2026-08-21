//
//  MainApi.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation
import Moya



enum MainApi {
   
    case getUserPayments(email: String, page: String)
    
}


extension MainApi: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self{
            
        case .getUserPayments:
            return "v2/get_user_payments.php"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .getUserPayments:
            .get
        }
    }
    
    var task: Moya.Task {
        switch self{
            
        case .getUserPayments(email: let email, page: let page):
            do{
                var params: [String: Any] = [:]
                params.addOptional(key: "email", value: email)
                params.addOptional(key: "page", value: page)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
            }
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
    
    
}



