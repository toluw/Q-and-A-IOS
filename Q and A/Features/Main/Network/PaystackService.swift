//
//  PaystackService.swift
//  Q and A
//
//  Created by GIGL-PC on 16/05/2026.
//

import Foundation


protocol PaystackServiceProtocol {
    

        func initiateTransaction(paystackData: PaystackData) async throws -> InititateTransactionResponse
    
    func verifyPayment(reference: String) async throws -> PaystackVerifyResponse
    
    
}


class PaystackService: PaystackServiceProtocol{
    
    
    
    private let apiClient = APIClient<PaystackApi>()
    
    func initiateTransaction(paystackData: PaystackData) async throws -> InititateTransactionResponse {
        
        return try await apiClient.request(
            .initiateTransaction(paystackData: paystackData),
            responseType: InititateTransactionResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        );
        
    }
    
    func verifyPayment(reference: String) async throws -> PaystackVerifyResponse {
        return try await apiClient.request(
            .verifyPayment(reference: reference),
            responseType: PaystackVerifyResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
            
        );
    }
    
    
   
    
    
}
