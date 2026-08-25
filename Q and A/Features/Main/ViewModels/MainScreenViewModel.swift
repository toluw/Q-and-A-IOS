//
//  MainScreenViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation
import GoogleSignIn

@MainActor
class MainScreenViewModel: ObservableObject{
   
    @Published var userProfileState: UserProfile = UserProfile()
    @Published var showLogin: Bool = false
    @Published var logoutMessage: ToastData? = nil
    @Published var showLoader: Bool = false
    
    
    private let service: MainServiceProtocol
    
    
      
      init(service:  MainServiceProtocol = MainService()) {
          self.service = service
      }
    
    func deactivate(){
        
        let deactivateBody = DeactivateBody(email: UserSettings.email ?? "")
        
        showLoader = true
        
        Task{
            do{
             let response =   try await service.deactivate(deactivateBody: deactivateBody)
                logoutUser()
                showLoader = false
                showSuccessMessage(message: "Your account has been successfully deactivated.", actionTitle: "Okay", showCancel: false, action: {})
                
                
                
             
                
            }catch{
                showLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.deactivate()
                })
            }
        }
        
    }
    
    
    private func logoutUser(){
        UserSettings.name  = ""
        UserSettings.email = ""
        UserSettings.phoneNumber = ""
        UserSettings.profileImage = ""
        UserSettings.isLoggedIn = false
        UserSettings.hasLaunchedBefore = false
        
        userProfileState = UserProfile()
        
        GIDSignIn.sharedInstance.signOut()
        
    }
    
   
    
    
    func reInitUserProfile(){
        userProfileState = UserProfile()
    }
    
    
    
    
}
