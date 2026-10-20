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
    case verifyPayment(reference: String)
    case getBank
    
}

extension PaystackApi: TargetType{
   
    
    var baseURL: URL {
        return URL(string: paystackUrl)!
    }
    
    var path: String {
        switch self {
            
            
        case .initiateTransaction:
            "transaction/initialize"
        
        case .verifyPayment(reference: let reference):
            "transaction/verify/\(reference)"
        case .getBank:
            "bank"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .initiateTransaction:
                .post
            
        case .verifyPayment(reference: let reference):
                .get
        case .getBank:
                .get
        }
    }
    
    var task: Moya.Task {
        switch self{
            
            
        case.initiateTransaction(paystackData: let paystackData):
            return .requestJSONEncodable(paystackData)
            
            
        case .verifyPayment(reference: let reference):
            return .requestPlain
        case .getBank:
            return .requestPlain
        }
        
        
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer \(UserSettings.paystackApiKey ?? "")"]
    }
    
    
}
