//
//  AuthService.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation


protocol AuthServiceProtocol {
    
    func login(loginRequest: LoginRequest) async throws -> LoginResponse
    func forgotPassword(forgotPasswordRequest: ForgotPasswordRequest) async throws -> GeneralResponse
    func changePassword(changePasswordRequest: ChangePasswordRequest) async throws -> GeneralResponse
    func socialLogin(socialLoginBody: SocialLoginBody) async throws -> SocialLoginResponse
    
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
        );        
    }
    
    func socialLogin(socialLoginBody: SocialLoginBody) async throws -> SocialLoginResponse {
        return try await apiClient.request(
            .socialLogin(payload: socialLoginBody),
            responseType: SocialLoginResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    func forgotPassword(forgotPasswordRequest: ForgotPasswordRequest) async throws -> GeneralResponse {
        return try await apiClient.request(
            .forgotPassword(payload: forgotPasswordRequest),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
    func changePassword(changePasswordRequest: ChangePasswordRequest) async throws -> GeneralResponse {
        return try await apiClient.request(
            .changePassword(payload: changePasswordRequest),
            responseType: GeneralResponse.self,
            errorParser: {data in
                data.jsonString(forKey: "message") ?? "An error occured"
            }
        );
    }
    
    
}
