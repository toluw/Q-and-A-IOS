//
//  CommunityService.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation

protocol CommunityServiceProtocol{
    
    func getPost(examId: String, questionId: String, buyerEmail: String, page: String) async throws -> PostResponse
    func likePost(postBody: PostBody) async throws -> GeneralResponse
    func deletePost(deletePostBody: DeletePostBody) async throws -> GeneralResponse
    
}


final class CommunityService: CommunityServiceProtocol{
   
    
    
   private let apiClient = APIClient<CommunityApi>()
    
    func deletePost(deletePostBody: DeletePostBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .deletePost(deletePostBody: deletePostBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
    }
    
    
    
    func likePost(postBody: PostBody) async throws -> GeneralResponse {
        
        return try await apiClient.request(
            .likePost(postBody: postBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
        
    }
    
    
    func getPost(examId: String, questionId: String, buyerEmail: String, page: String) async throws -> PostResponse {
    
        return try await apiClient.request(
            .getPost(examId: examId, questionId: questionId, buyerEmail: buyerEmail, page: page, pageSize: String(PAGE_SIZE)), responseType: PostResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
        
    }
    
    
    
}
