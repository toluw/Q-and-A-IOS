//
//  ChangePasswordState.swift
//  Q and A
//
//  Created by GIGL-PC on 09/04/2026.
//

import Foundation

struct ChangePasswordState{
    
    var password: String = ""
    var confirmPassword: String = ""
    var isLoading: Bool = false
    var errorMessage: ToastData? = nil
    var isSuccess: Bool = false
    
}
