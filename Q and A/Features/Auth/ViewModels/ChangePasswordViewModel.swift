//
//  ChangePasswordViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 09/04/2026.
//

import Foundation

@MainActor
class ChangePasswordViewModel: ObservableObject{
    
    @Published var state = ChangePasswordState()
    @Published var showLogin: Bool = false
    
    private let service: AuthServiceProtocol
      
    init(service: AuthServiceProtocol = AuthService()) {
          self.service = service
    }
    
    func validate() -> Bool{
        
        if(state.password == ""){
            state.errorMessage = ToastData(message: "Please enter your password", type: .error)
            return false
        }
        
        if(state.confirmPassword == ""){
            state.errorMessage = ToastData(message: "Please confirm your new password", type: .error)
            return false
        }
        
        if(state.password != state.confirmPassword){
            state.errorMessage = ToastData(message: "The password you entered does not match", type: .error)
            return false
        }
        
        return true
        
    }
    
    func changePassword(email: String){
        
           guard validate() else { return }
            
            state.isLoading = true
            
            Task{
                do {
                    
                    
                    let changePasswordRequest = ChangePasswordRequest(email: email, password: state.password)
                    
                    
                    let response = try await service.changePassword(changePasswordRequest: changePasswordRequest)
                    
                    state.isLoading = false
                    state.isSuccess = true
                    
                    
                } catch {
                    state.isLoading = false
                    
                    showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                        self.changePassword(email: email)
                    })
                }
            }
            
        
        
        
    }
    
    
    
}
