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
               state.errorMessage = "Please enter your email"
               return false
           }
           
           if !state.email.isValidEmail(){
               state.errorMessage = "The email you entered is not valid"
               return false
           }
           
           if state.password.isEmpty {
               state.errorMessage = "Please enter your password"
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
                   
                   guard let data = response.data else {
                       state.isLoading = false
                       state.errorMessage = "Something went wrong"
                       return
                       }
                   
                   
                   loginUser(userData: data)
                   
                   replaceLibrary(libraryContent: data.library ?? [])
                   
                   state.isLoading = false
                   state.isSuccess = true
                   
                   
                   print("Welcome \(response.data?.firstname ?? "")")
                   
               } catch {
                   state.isLoading = false
                   state.errorMessage = error.localizedDescription
               }
           }
       }
    
    
    func loginUser(userData: LoginResponse.UserData){
        
        UserSettings.name  = "\(userData.firstname) \(userData.lastname)"
        UserSettings.email = userData.email
        UserSettings.phoneNumber = userData.phone
        UserSettings.profileImage = userData.image
        UserSettings.isLoggedIn = true
        
        state.userProfile = UserProfile()
        
        
    }
    
    func replaceLibrary(libraryContent: [LoginResponse.Library]){
        
        
        
    }
    
    
    
    
    
    
    
}
