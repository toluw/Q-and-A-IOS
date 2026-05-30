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
    case getSubCatExams(cbtId: String, buyerEmail: String?, isActive: String = "1")
    case getExamQuestions(examId: String, buyerEmail: String)
    case getCatExams(cbtId: String, buyerEmail: String?, isActive: String = "1")
    case getMultipleExams(multipleExamBody: MultipleExamsBody)
    case postTransaction(postTransactionBody: PostTransactionBody)
    
}

extension CbtAPI: TargetType{
   
    
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
            
        case .getParentCategories:
            return "v2/get_parent_category2.php"
        case .getSubCatExams:
            return "v2/get_subcat_exams.php"
        case .getMultipleExams:
            return "v2/get_multiple_exam_questions.php"
        case .postTransaction:
            return "v2/post_transaction.php"
        case .getCatExams:
            return "v2/get_cat_exams.php"
        case .getExamQuestions(examId: let examId, buyerEmail: let buyerEmail):
            return "v2/get_exam_questions.php"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .getParentCategories:
                .get
            
        case .getSubCatExams:
                .get
            
            
        case .getMultipleExams:
                .post
        case .postTransaction:
                .post
        case .getCatExams:
                .get
        case .getExamQuestions:
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
            
            
        case .getSubCatExams(cbtId: let cbtId, buyerEmail: let buyerEmail, isActive: let isActive):
            
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "cbt_id", value: cbtId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "is_active", value: isActive)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
            
            
        case .getMultipleExams(multipleExamBody: let multipleExamBody):
            return .requestJSONEncodable(multipleExamBody)
            
        case .postTransaction(postTransactionBody: let postTransactionBody):
            return .requestJSONEncodable(postTransactionBody)
            
        case .getCatExams(cbtId: let cbtId, buyerEmail: let buyerEmail, isActive: let isActive):
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "cbt_id", value: cbtId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "is_active", value: isActive)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
        case .getExamQuestions(examId: let examId, buyerEmail: let buyerEmail):
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "exam_id", value: examId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                
                
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
