//
//  CommunityService.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation

protocol CommunityServiceProtocol{
    
    func getPost(examId: String, questionId: String, buyerEmail: String, page: String) async throws -> PostResponse
    func getPostById(id: String, buyerEmail: String) async throws -> SinglePostResponse
    func getComment(postId: String, buyerEmail: String, page: String) async throws -> ForumCommentResponse
    func likePost(postBody: PostBody) async throws -> GeneralResponse
    func deletePost(deletePostBody: DeletePostBody) async throws -> GeneralResponse
    func createPost(createPostBody: CreatePostBody) async throws -> GeneralResponse
    func updatePost(updatePostBody: UpdatePostBody) async throws -> GeneralResponse
    func createComment(createCommentBody: CreateCommentBody) async throws -> GeneralResponse
    func updateComment(updateCommentBody: UpdateCommentBody) async throws -> GeneralResponse
    func deleteComment(deleteCommentBody: DeleteCommentBody) async throws -> GeneralResponse
    func likeComment(likeCommentBody: LikeCommentBody) async throws -> GeneralResponse
    
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
    
    func deleteComment(deleteCommentBody: DeleteCommentBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .deleteComment(deleteCommentBody: deleteCommentBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
    }
    
    
    func createPost(createPostBody: CreatePostBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .createPost(createPostBody: createPostBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
    }
    
    func createComment(createCommentBody: CreateCommentBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .createComment(createCommentBody: createCommentBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
    }
    
    func updatePost(updatePostBody: UpdatePostBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .updatePost(updatePostBody: updatePostBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
    }
    
    
    func updateComment(updateCommentBody: UpdateCommentBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .updateComment(updateCommentBody: updateCommentBody),
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
    
    func likeComment(likeCommentBody: LikeCommentBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .likeComment(likeCommentBody: likeCommentBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
    }
    
    func getPostById(id: String, buyerEmail: String) async throws -> SinglePostResponse {
        
        return try await apiClient.request(
            .getPostById(id: id, buyerEmail: buyerEmail),
            responseType: SinglePostResponse.self,
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
    
    func getComment(postId: String, buyerEmail: String, page: String) async throws -> ForumCommentResponse {
    
        return try await apiClient.request(
            .getComment(postId: postId, buyerEmail: buyerEmail, page: page, pageSize: String(PAGE_SIZE)),
            responseType: ForumCommentResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
        
    }
    
    
    
    
}
