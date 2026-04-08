//
//  ForgotPasswordRequest.swift
//  Q and A
//
//  Created by GIGL-PC on 07/04/2026.
//

import Foundation

struct ForgotPasswordRequest: Encodable{
    let email: String
    let code: String
}
