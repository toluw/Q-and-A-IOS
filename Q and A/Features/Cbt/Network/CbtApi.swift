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
    
    case getParentCategories(level: String? = nil, cbcId: String? = nil, isActive: String = "1", isMock: String, deviceId: String, buyerEmail: String)
    case getSubCatExams(cbtId: String, buyerEmail: String?, isActive: String = "1", deviceId: String)
    case getCbtQuestions(examId: String, buyerEmail: String, isAndroid: String = "0", deviceId: String = DeviceManager.shared.getDeviceId())
    case getCatExams(cbtId: String, buyerEmail: String?, isActive: String = "1", deviceId: String)
    case getMultipleExams(multipleExamBody: MultipleExamsBody)
    case postTransaction(postTransactionBody: PostTransactionBody)
    case postResult(examResultBody: ExamResultBody)
    case postUnFinishedResult(unFinishedResultBody: UnfinishedResultBody)
    case askAiCbt(askAiCbtBody: AskAiCbtBody)
    case getNumPost(examId: String, questionId: String)
    case getCbtHistory(buyerEmail: String, isCompleted: String, page: String, pageSize: String = String(PAGE_SIZE))
    case getLiveExam(resultId: String)
    
}

extension CbtAPI: TargetType{
   
    
    
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self {
            
        case .getParentCategories:
            return "v2/get_parent_category3.php"
        case .getSubCatExams:
            return "v2/get_subcat_exams2.php"
        case .getMultipleExams:
            return "v2/get_multiple_exam_questions2.php"
        case .postTransaction:
            return "v2/post_transaction2.php"
        case .getCatExams:
            return "v2/get_cat_exams2.php"
        case .getCbtQuestions:
            return "v2/get_cbt_questions.php"
        case .postResult:
            return "v2/post_result4.php"
        case .postUnFinishedResult:
            return "v2/post_unfinished_result3.php"
        case .askAiCbt:
           return "v2/ask_ai_cbt.php"
        case .getNumPost:
           return "v2/get_num_post.php"
        case .getCbtHistory:
           return  "v2/get_cbt_history.php"
        case .getLiveExam:
            return  "v2/get_live_exam.php"
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
        case .getCbtQuestions:
                .get
        case .postResult:
                .post
        case .postUnFinishedResult:
                .post
        case .askAiCbt:
                .post
        case .getNumPost:
                .get
        case .getCbtHistory:
                .get
        case .getLiveExam:
                .get
        }
    }
    
    var task: Moya.Task {
        switch self{
            
        case .getParentCategories(level: let level, cbcId: let cbcId, isActive: let isActive, isMock: let isMock, deviceId: let deviceId, buyerEmail: let buyerEmail):
            
            do {
                
                var params: [String: Any] = [:]
                params.addOptional(key: "level", value: level)
                params.addOptional(key: "cbc_id", value: cbcId)
                params.addOptional(key: "is_active", value: isActive)
                params.addOptional(key: "is_mock", value: isMock)
                params.addOptional(key: "device_id", value: deviceId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
            
        case .getSubCatExams(cbtId: let cbtId, buyerEmail: let buyerEmail, isActive: let isActive, deviceId: let deviceId):
            
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "cbt_id", value: cbtId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "is_active", value: isActive)
                params.addOptional(key: "device_id", value: deviceId)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
            
            
        case .getMultipleExams(multipleExamBody: let multipleExamBody):
            return .requestJSONEncodable(multipleExamBody)
            
        case .postTransaction(postTransactionBody: let postTransactionBody):
            return .requestJSONEncodable(postTransactionBody)
            
        case .postResult(examResultBody: let examResultBody):
            return .requestJSONEncodable(examResultBody)
            
        case .postUnFinishedResult(unFinishedResultBody: let unFinishedResultBody):
            return .requestJSONEncodable(unFinishedResultBody)
            
        case .askAiCbt(askAiCbtBody: let askAiCbtBody):
            return .requestJSONEncodable(askAiCbtBody)
            
        case .getCatExams(cbtId: let cbtId, buyerEmail: let buyerEmail, isActive: let isActive, deviceId: let deviceId):
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "cbt_id", value: cbtId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "is_active", value: isActive)
                params.addOptional(key: "device_id", value: deviceId)
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
        case .getCbtQuestions(examId: let examId, buyerEmail: let buyerEmail, isAndroid: let isAndroid, deviceId: let deviceId):
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "exam_id", value: examId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "is_android", value: isAndroid)
                params.addOptional(key: "device_id", value: deviceId)
                
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
            
        
        
       
        case .getNumPost(examId: let examId, questionId: let questionId):
            do {
                var params: [String: Any] = [:]
                params.addOptional(key: "exam_id", value: examId)
                params.addOptional(key: "question_id", value: questionId)
                
                
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
        case .getCbtHistory(buyerEmail: let buyerEmail, isCompleted: let isCompleted, page: let page, pageSize: let pageSize):
            do{
              
                var params: [String: Any] = [:]
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "is_completed", value: isCompleted)
                params.addOptional(key: "page", value: page)
                params.addOptional(key: "page_size", value: pageSize)
                
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
                
                
            }
        case .getLiveExam(resultId: let resultId):
            do{
                
                var params: [String: Any] = [:]
                params.addOptional(key: "result_id", value: resultId)
                
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
