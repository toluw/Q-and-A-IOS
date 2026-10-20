//
//  MainApi.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation
import Moya



enum MainApi {
    case getCbtPayoutHistory(email: String)
    case getAgentIncome(email: String)
    case getIncome(email: String)
    case getPortalData(email: String)
   
    case getUserPayments(email: String, page: String)
    case getPaymentDetail(type: String, reference: String)
    case deactivate(deactivateBody: DeactivateBody)
    case updateToken(updateTokenBody: UpdateTokenBody)
    
}


extension MainApi: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self{
        case .getCbtPayoutHistory:
            return "v2/get_cbt_payout_history.php"
        case .getAgentIncome:
            return "v2/get_agent_income.php"
        case .getIncome:
            return "v2/get_income.php"
        case .getPortalData:
            return "v2/get_portal_data.php"
            
        case .getUserPayments:
            return "v2/get_user_payments.php"
        case .getPaymentDetail:
            return "v2/get_payment_details.php"
        case .deactivate:
            return "v2/deactivate.php"
        case .updateToken:
           return "v2/update_ios_token.php"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .getCbtPayoutHistory:
            .get
        case .getAgentIncome:
            .get
        case .getIncome:
            .get
        case .getPortalData:
            .get
            
        case .getUserPayments:
            .get
        case .getPaymentDetail:
            .get
        case .deactivate:
            .post
        case .updateToken:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .getCbtPayoutHistory(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .getAgentIncome(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .getIncome(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .getPortalData(email: let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
            
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
        case .updateToken(updateTokenBody: let updateTokenBody):
            return .requestJSONEncodable(updateTokenBody)
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
    
    
}



