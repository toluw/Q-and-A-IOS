//
//  MainService.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation

protocol MainServiceProtocol{
    
    func getUserPayments(email: String, page: String) async throws -> PaymentResponse
    
    func getPaymentDetails(reference: String, type: String) async throws -> PaymentDetailsResponse
    
    func deactivate(deactivateBody: DeactivateBody)  async throws -> GeneralResponse
    
    
}

final class MainService: MainServiceProtocol{
   
   
    
    
    
    private let apiClient = APIClient<MainApi>()
    
    
    
    
    func getUserPayments(email: String, page: String) async throws -> PaymentResponse {
        return try await apiClient.request(
            .getUserPayments(email: email, page: page),
            responseType: PaymentResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
    }
    
    
    func deactivate(deactivateBody: DeactivateBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .deactivate(deactivateBody: deactivateBody),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        )
    }
    
   
    
    
    
    func getPaymentDetails(reference: String, type: String) async throws -> PaymentDetailsResponse {
        return try await apiClient.request(
            .getPaymentDetail(type: type, reference: reference),
            responseType: PaymentDetailsResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
    }
    
   
   
    
    
    
    
    
    
    
    
    
    
}
