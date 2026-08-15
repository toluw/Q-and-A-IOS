//
//  LoginViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation
import AuthenticationServices
import GoogleSignIn

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
    
    
    func handleAppleSignIn(result: Result<ASAuthorization, Error>){
        
        switch result {

                case .success(let auth):

                    guard let credential = auth.credential as? ASAuthorizationAppleIDCredential else {
                        state.errorMessage =  ToastData(message: "An error occured, try again later - 1", type: .error)
                        return
                    }

                    let userId = credential.user

                    let email = credential.email

                    let fullName = credential.fullName

                    let identityToken = credential.identityToken

                    let authorizationCode = credential.authorizationCode

                    if let identityToken,
                       let tokenString = String(data: identityToken, encoding: .utf8) {

                        print(tokenString)

                        // Send token to backend
                    }

                    print(userId)
                    print(email ?? "")
                    print(fullName?.givenName ?? "")
            
               state.appleUSer = AppleUser(name: fullName?.givenName, email: email, appleId: userId)
            
            let socialLoginBody = SocialLoginBody(token: UserSettings.token ?? "", device_id: DeviceManager.shared.getDeviceId(), apple_id: userId, email: email)
            
            socialLogin(socialLoginBody: socialLoginBody)

                case .failure(let error):
                   state.errorMessage =  ToastData(message: error.localizedDescription, type: .error)
                    print(error.localizedDescription)
                }
            }
        
        
    
    
    func socialSignUp(socialSignUpBody: SocialSignupBody){
        state.isLoading = true
        state.errorMessage = nil
        
        Task{
            do{
                
                let data = try await service.socialSignUp(socialSignUpBody: socialSignUpBody).data
                loginUser(name: data.name, email: data.email, phoneNumber: data.phone, profileImage: data.image, paystackApiKey: data.paystackApiKey)
                
                replaceLibrary(libraryContent: data.library ?? [])
                
                state.isLoading = false
                state.isSuccess = true
                
            }catch {
                state.isLoading = false
                state.errorMessage =  ToastData(message: error.localizedDescription, type: .error)
            }
            
            
        }
        
        
    }

    
    func socialLogin(socialLoginBody: SocialLoginBody){
        
        state.isLoading = true
        state.errorMessage = nil
        
        Task{
            do{
                let data = try await service.socialLogin(socialLoginBody: socialLoginBody).data
                
                if(data.isRegistered){
                    
                    loginUser(name: data.name ?? "", email: data.email ?? "", phoneNumber: data.phone, profileImage: data.image, paystackApiKey: data.paystackApiKey)
                    
                    replaceLibrary(libraryContent: data.library ?? [])
                    
                    state.isLoading = false
                    state.isSuccess = true
                }else{
                    //Move to phone number confirmation
                    if(data.email != nil){
                        state.appleUSer?.email = data.email
                    }
                    if(data.name != nil){
                        state.appleUSer?.name = data.name
                    }
                    state.isLoading = false
                    
                    if(state.appleUSer?.name == nil || state.appleUSer?.email == nil){
                        state.errorMessage =  ToastData(message: "Cannot login, try another login method", type: .error)
                    }else{
                        state.loginAspect = .ConfirmPhone
                    }
                    
                    
                }
                
            }catch {
                state.isLoading = false
                state.errorMessage =  ToastData(message: error.localizedDescription, type: .error)
            }
            
        }
        
    }
    
    func validatePhoneNumber(phoneNumber: String)-> Bool{
        if(phoneNumber.isEmpty){
            state.errorMessage =  ToastData(message: "Please enter your phone number", type: .error)
            return false
        }
        
        if(!phoneNumber.isValidMobile()){
            state.errorMessage =  ToastData(message: "Please enter a valid phone number", type: .error)
            return false
        }
        
        return true
    }
    
    
    
    func googleLogin(){
        
        
        state.isLoading = true
        
        guard let rootViewController = UIApplication.shared.connectedScenes
                  .compactMap({ $0 as? UIWindowScene })
                  .first?.windows.first?.rootViewController else {
                  return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController){ [self]result, error in
            
            Task { @MainActor in
                
               
                if let error = error {
                    let errorMessage = error.localizedDescription
                    state.errorMessage =  ToastData(message: errorMessage, type: .error)
                    self.state.isLoading = false
                    
                    return
                }
                
                guard let user = result?.user.profile else {
                    
                    
                    state.errorMessage =  ToastData(message: "Could not retrieve user details, try again", type: .error)
                    self.state.isLoading = false
                    
                    return
                }
                    
                
                state.appleUSer = AppleUser(name: user.name, email: user.email, appleId: nil)
                
                
                
            }
            
          
            
            
        }
        
        
        
        
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
                   
                   
                   loginUser(name: "\(data.firstname) \(data.lastname)", email: data.email, phoneNumber: data.phone, profileImage: data.image, paystackApiKey: data.paystack_api_key)
                   
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
    
    
    
    
    func loginUser(name: String, email: String, phoneNumber: String?, profileImage: String?, paystackApiKey: String){
        UserSettings.name  =  name
        UserSettings.email = email.lowercased()
        UserSettings.phoneNumber = phoneNumber
        UserSettings.profileImage = profileImage
        UserSettings.isLoggedIn = true
        UserSettings.paystackApiKey = paystackApiKey
        
        state.userProfile = UserProfile()
    }
    
   
    func replaceLibrary(libraryContent: [LoginResponse.Library]){
        
        
        
    }
    
    
    
    
    
    
    
}
