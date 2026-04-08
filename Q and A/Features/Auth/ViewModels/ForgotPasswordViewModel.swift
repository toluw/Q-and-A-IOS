//
//  ForgotPasswordViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 07/04/2026.
//

import Foundation


@MainActor
class ForgotPasswordViewModel: ObservableObject {
    
    @Published var state = ForgotPasswordState()
    
    private let service: AuthServiceProtocol
      
    init(service: AuthServiceProtocol = AuthService()) {
          self.service = service
    }
    
   
    func validate() -> Bool {
           if state.email.isEmpty {
               state.errorMessage = ToastData(message: "Please enter your email", type: .error)
               return false
           }
           
           if !state.email.isValidEmail(){
               state.errorMessage =  ToastData(message: "The email you entered is not valid", type: .error)
               return false
           }
           
           return true
    }
    
    
    func forgotPassword(){
        
        guard validate() else { return }
        
        state.isLoading = true
        
        Task{
            do {
                
                state.code = String(Int.random(in: 100000...999999))
                
                let forgotPasswordRequest = ForgotPasswordRequest(email: state.email, code: state.code)
                
                let response = try await service.forgotPassword(forgotPasswordRequest: forgotPasswordRequest)
                
                state.isLoading = false
                state.isSuccess = true
                
                
            } catch {
                state.isLoading = false
                
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: forgotPassword)
            }
        }
        
    }
    
    
   
    
    
    
    
}

