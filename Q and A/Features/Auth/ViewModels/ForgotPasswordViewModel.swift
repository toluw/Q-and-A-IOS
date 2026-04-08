//
//  ForgotPasswordViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 07/04/2026.
//

import Foundation


@MainActor
class ForgotPasswordViewModel: ObservableObject {
    
    @Published var state = LoginState()
    
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
        
    }
    
    
    
    
}

