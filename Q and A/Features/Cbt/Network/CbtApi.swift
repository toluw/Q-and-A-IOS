//
//  CbtApi.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import Foundation

import Foundation
import Moya


enum CbtAPI {
    
    case getParentCategories(level: String? = nil, cbcId: String? = nil, isActive: String = "1", isMock: String)
    
}

extension CbtAPI: TargetType{
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
            
        case .getParentCategories:
            return "v2/get_parent_category2.php"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .getParentCategories:
                .get
            
        }
    }
    
    var task: Moya.Task {
        switch self{
            
        case .getParentCategories(level: let level, cbcId: let cbcId, isActive: let isActive, isMock: let isMock):
            
            do {
                
                var params: [String: Any] = [:]
                params.addOptional(key: "level", value: level)
                params.addOptional(key: "cbc_id", value: cbcId)
                params.addOptional(key: "is_active", value: isActive)
                params.addOptional(key: "is_mock", value: isMock)
              
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
