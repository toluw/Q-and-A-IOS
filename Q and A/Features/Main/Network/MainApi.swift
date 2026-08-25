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
    case getPaymentDetail(type: String, reference: String)
    case deactivate(deactivateBody: DeactivateBody)
    
}


extension MainApi: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self{
            
        case .getUserPayments:
            return "v2/get_user_payments.php"
        case .getPaymentDetail:
            return "v2/get_payment_details.php"
        case .deactivate:
            return "v2/deactivate.php"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .getUserPayments:
            .get
        case .getPaymentDetail:
            .get
        case .deactivate:
            .post
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
        case .getPaymentDetail(type: let type, reference: let reference):
            do{
                var params: [String: Any] = [:]
                params.addOptional(key: "type", value: type)
                params.addOptional(key: "reference", value: reference)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
            }
        case .deactivate(deactivateBody: let deactivateBody):
            return .requestJSONEncodable(deactivateBody)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
    
    
}



