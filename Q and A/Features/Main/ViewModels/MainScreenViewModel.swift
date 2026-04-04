//
//  MainScreenViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation

@MainActor
class MainScreenViewModel: ObservableObject{
   
    @Published var userProfileState: UserProfile = UserProfile()
    
    
    func reInitUserProfile(){
        userProfileState = UserProfile()
    }
    
}
