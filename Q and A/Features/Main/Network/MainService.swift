//
//  MainService.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation

protocol MainServiceProtocol{
    func getAccount(email: String) async throws -> AccountResponse
    func setAccount(body: SetAccountBody) async throws -> GeneralResponse
    func getAgentPayoutHistory(email: String) async throws -> CbtPayoutHistoryResponse
    func getCbtPayoutHistory(email: String) async throws -> CbtPayoutHistoryResponse
    func getAgentIncome(email: String) async throws -> EarningsCbtResponse
    func getIncome(email: String) async throws -> EarningsCbtResponse
    func getPortalData(email: String) async throws -> PortalResponse
    
    func getUserPayments(email: String, page: String) async throws -> PaymentResponse
    
    func getPaymentDetails(reference: String, type: String) async throws -> PaymentDetailsResponse
    
    func deactivate(deactivateBody: DeactivateBody)  async throws -> GeneralResponse
    
    func updateToken(updateTokenBody: UpdateTokenBody) async throws -> GeneralResponse
    
    
}

final class MainService: MainServiceProtocol{
    func getAccount(email: String) async throws -> AccountResponse {
        try await apiClient.request(
            .getAccount(email: email), responseType: AccountResponse.self,
            errorParser: { $0.jsonString(forKey: "message") ?? "Unable to load account details." }
        )
    }

    func setAccount(body: SetAccountBody) async throws -> GeneralResponse {
        try await apiClient.request(
            .setAccount(body: body), responseType: GeneralResponse.self,
            errorParser: { $0.jsonString(forKey: "message") ?? "Unable to save account details." }
        )
    }

    func getAgentPayoutHistory(email: String) async throws -> CbtPayoutHistoryResponse {
        try await apiClient.request(
            .getAgentPayoutHistory(email: email),
            responseType: CbtPayoutHistoryResponse.self,
            errorParser: { $0.jsonString(forKey: "message") ?? "Unable to load agency payout history." }
        )
    }

    func getCbtPayoutHistory(email: String) async throws -> CbtPayoutHistoryResponse {
        try await apiClient.request(
            .getCbtPayoutHistory(email: email),
            responseType: CbtPayoutHistoryResponse.self,
            errorParser: { $0.jsonString(forKey: "message") ?? "Unable to load payout history." }
        )
    }

    func getAgentIncome(email: String) async throws -> EarningsCbtResponse {
        try await apiClient.request(
            .getAgentIncome(email: email),
            responseType: EarningsCbtResponse.self,
            errorParser: { $0.jsonString(forKey: "message") ?? "Unable to load agency earnings." }
        )
    }

    func getIncome(email: String) async throws -> EarningsCbtResponse {
        try await apiClient.request(
            .getIncome(email: email),
            responseType: EarningsCbtResponse.self,
            errorParser: { $0.jsonString(forKey: "message") ?? "Unable to load earnings." }
        )
    }

    func getPortalData(email: String) async throws -> PortalResponse {
        return try await apiClient.request(
            .getPortalData(email: email),
            responseType: PortalResponse.self,
            errorParser: { data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        )
    }
  
   
    
    
    
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
    
    
    func updateToken(updateTokenBody: UpdateTokenBody) async throws -> GeneralResponse {
        return try await apiClient.request(
            .updateToken(updateTokenBody: updateTokenBody),
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
