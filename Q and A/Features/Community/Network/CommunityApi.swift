//
//  CommunityApi.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation
import Moya


enum CommunityApi{
    
    case getPost(examId: String, questionId: String, buyerEmail: String, page: String, pageSize: String = String(PAGE_SIZE))
    
    case likePost(postBody: PostBody)
    
    case deletePost(deletePostBody: DeletePostBody)
    
    
    
}


extension CommunityApi: TargetType{
    var baseURL: URL {
        return URL(string: baseUrl)!
    }
    
    var path: String {
        switch self{
            
        case .getPost:
            return "v2/get_post.php"
        
        case .likePost:
            return "v2/like_post.php"
        case .deletePost:
            return "v2/delete_cbt_post.php"
        }
    }
    
    var method: Moya.Method {
        switch self{
            
        case .getPost:
            .get
        case .likePost:
            .post
        case .deletePost:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self{
            
        case .getPost(examId: let examId, questionId: let questionId, buyerEmail: let buyerEmail, page: let page, pageSize: let pageSize):
            
            do {
                
                var params: [String: Any] = [:]
                params.addOptional(key: "exam_id", value: examId)
                params.addOptional(key: "question_id", value: questionId)
                params.addOptional(key: "buyer_email", value: buyerEmail)
                params.addOptional(key: "page", value: page)
                params.addOptional(key: "page_size", value: pageSize)
                
                
                return .requestParameters(
                    parameters: params,
                    encoding: URLEncoding.queryString
                )
                
            }
            
        case .likePost(postBody: let postBody):
            return .requestJSONEncodable(postBody)
        case .deletePost(deletePostBody: let deletePostBody):
            return .requestJSONEncodable(deletePostBody)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
    
    
}
