//
//  LoginState.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation

struct LoginState {
    var email: String = ""
    var password: String = ""
    
    var isLoading: Bool = false
    var errorMessage: ToastData? = nil
    var isSuccess: Bool = false
    var isPhoneConfirmationScreen: Bool = false
    var userProfile : UserProfile? = nil
}
