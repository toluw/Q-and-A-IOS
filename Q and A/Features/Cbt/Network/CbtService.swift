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
    
    
}


