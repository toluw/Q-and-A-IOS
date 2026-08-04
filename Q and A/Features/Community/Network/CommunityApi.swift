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
    
    case getComment(postId: String, buyerEmail: String, page: String, pageSize: String = String(PAGE_SIZE))
    
    case likePost(postBody: PostBody)
    
    case deletePost(deletePostBody: DeletePostBody)
    
    case createPost(createPostBody: CreatePostBody)
    
    
    case updatePost(updatePostBody: UpdatePostBody)
    
    
    
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
        case .createPost(createPostBody: let createPostBody):
            return "v2/create_post.php"
        case .updatePost(updatePostBody: let updatePostBody):
            return "v2/update_cbt_post.php"
        case .getComment:
            return "v2/get_cbt_comment.php"
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
        case .createPost:
            .post
        case .updatePost(updatePostBody: let updatePostBody):
            .post
        case .getComment:
                .get
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
            
        case .getComment(postId: let postId, buyerEmail: let buyerEmail, page: let page, pageSize: let pageSize):
            do {
                
                var params: [String: Any] = [:]
                params.addOptional(key: "post_id", value: postId)
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
        case .createPost(createPostBody: let createPostBody):
            return .requestJSONEncodable(createPostBody)
        case .updatePost(updatePostBody: let updatePostBody):
            return .requestJSONEncodable(updatePostBody)
        
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Key": apiKey]
    }
    
    
    
}
