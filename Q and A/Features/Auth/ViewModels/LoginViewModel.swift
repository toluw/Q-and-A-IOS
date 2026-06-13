//
//  LoginViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject{
    
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
           
           if state.password.isEmpty {
               state.errorMessage = ToastData(message: "Please enter your password", type: .error)
               return false
           }
           
           return true
    }
    
    
    
    
    func login() {
           guard validate() else { return }
           
           state.isLoading = true
           state.errorMessage = nil
           
           Task {
               do {
                   
                   let loginRequest = LoginRequest(email: state.email,
                                                   password: state.password,
                                                   token: UserSettings.token ?? "",
                                                   deviceId: DeviceManager.shared.getDeviceId())
                   
                   let response = try await service.login(
                      loginRequest: loginRequest
                   )
                   
                  
                   if(!response.status){
                       state.isLoading = false
                       state.errorMessage = ToastData(message: response.message, type: .error)
                       return
                   }
                   
                   guard let data = response.data else {
                       state.isLoading = false
                       state.errorMessage = ToastData(message: "Something went wrong", type: .error)
                       return
                       }
                   
                   
                   loginUser(userData: data)
                   
                   replaceLibrary(libraryContent: data.library ?? [])
                   
                   state.isLoading = false
                   state.isSuccess = true
                   
                   
                   print("Welcome \(response.data?.firstname ?? "")")
                   
               } catch {
                   state.isLoading = false
                   state.errorMessage =  ToastData(message: error.localizedDescription, type: .error)
               }
           }
       }
    
    
    func loginUser(userData: LoginResponse.UserData){
        
        UserSettings.name  = "\(userData.firstname) \(userData.lastname)"
        UserSettings.email = userData.email.lowercased()
        UserSettings.phoneNumber = userData.phone
        UserSettings.profileImage = userData.image
        UserSettings.isLoggedIn = true
        UserSettings.paystackApiKey = userData.paystack_api_key
        
        state.userProfile = UserProfile()
        
        
    }
    
    func replaceLibrary(libraryContent: [LoginResponse.Library]){
        
        
        
    }
    
    
    
    
    
    
    
}
