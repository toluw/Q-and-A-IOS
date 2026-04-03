//
//  AuthService.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation


protocol AuthServiceProtocol {
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse
}


final class AuthService: AuthServiceProtocol{
    
    private let apiClient = APIClient<AuthAPI>()
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse {
        
        return try await apiClient.request(
            .login(payload: loginRequest),
            responseType: LoginResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );        <#code#>
    }
    
    
}
