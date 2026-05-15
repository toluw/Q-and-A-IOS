//
//  PaystackApi.swift
//  Q and A
//
//  Created by GIGL-PC on 15/05/2026.
//

import Foundation

import Foundation
import Moya


enum PaystackApi {
    
   
    case initiateTransaction(paystackData: PaystackData)
    
}

extension PaystackApi: TargetType{
   
    
    var baseURL: URL {
        return URL(string: paystackUrl)!
    }
    
    var path: String {
        switch self {
            
            
        case .initiateTransaction:
            "transaction/initialize"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .initiateTransaction:
                .post
            
        }
    }
    
    var task: Moya.Task {
        switch self{
            
            
        case.initiateTransaction(paystackData: let paystackData):
            return .requestJSONEncodable(paystackData)
            
            
        }
        
        
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(paystackSecret)"]
    }
    
    
}
