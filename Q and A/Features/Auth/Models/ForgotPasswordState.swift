//
//  ForgotPasswordState.swift
//  Q and A
//
//  Created by GIGL-PC on 07/04/2026.
//

import Foundation


struct ForgotPasswordState{
    
    var email: String = ""
    var isLoading: Bool = false
    var errorMessage: ToastData? = nil
    var isSuccess: Bool = false
    var code: String = ""
    
}
