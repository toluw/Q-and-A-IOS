//
//  CbtService.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import Foundation

protocol CbtServiceProtocol {
    
    func getParentCategories(level: String?, cbcId: String?, isActive: String, isMock: String) async throws -> ParentCategoriesResponse
    func getSubCatExams(cbtId: String, buyerEmail: String?) async throws -> SubCatExamsResponse
    func getMultipleExams(multipleExamBody: MultipleExamsBody) async throws -> MultipleExamsResponse
    func postTransaction(postTransactionBody: PostTransactionBody) async throws -> GeneralResponse
    func getCatExams(cbtId: String, buyerEmail: String?) async throws -> CatExamsResponse
    
    
    
}


final class CbtService: CbtServiceProtocol{
   
   
    
   
    
    private let apiClient = APIClient<CbtAPI>()
    
    func getParentCategories(level: String?, cbcId: String?, isActive: String, isMock: String) async throws -> ParentCategoriesResponse {
        return try await apiClient.request(
            .getParentCategories(level: level, cbcId: cbcId, isActive: isActive, isMock: isMock),
            responseType: ParentCategoriesResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    func getSubCatExams(cbtId: String, buyerEmail: String?) async throws -> SubCatExamsResponse {
        return try await apiClient.request(
            .getSubCatExams(cbtId: cbtId, buyerEmail: buyerEmail),
            responseType: SubCatExamsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    func getCatExams(cbtId: String, buyerEmail: String?) async throws -> CatExamsResponse {
        return try await apiClient.request(
            .getCatExams(cbtId: cbtId, buyerEmail: buyerEmail),
            responseType: CatExamsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    func getMultipleExams(multipleExamBody: MultipleExamsBody) async throws -> MultipleExamsResponse {
        return try await apiClient.request(
            .getMultipleExams(multipleExamBody: multipleExamBody),
            responseType: MultipleExamsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    func postTransaction(postTransactionBody: PostTransactionBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .postTransaction(postTransactionBody: postTransactionBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        );
    }
    
    
    
    
    
}


