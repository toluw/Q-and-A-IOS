//
//  CommunityService.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation

protocol CommunityServiceProtocol{
    
    func getPost(examId: String, questionId: String, buyerEmail: String, page: String) async throws -> PostResponse
    
}


final class CommunityService: CommunityServiceProtocol{
    

    private let apiClient = APIClient<CommunityApi>()
    
    
    
    func getPost(examId: String, questionId: String, buyerEmail: String, page: String) async throws -> PostResponse {
    
        return try await apiClient.request(
            .getPost(examId: examId, questionId: questionId, buyerEmail: buyerEmail, page: page, pageSize: String(PAGE_SIZE)), responseType: PostResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
        
    }
    
    
    
}
