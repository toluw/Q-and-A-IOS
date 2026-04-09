//
//  ChangePasswordRequest.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import Foundation

struct ChangePasswordRequest: Encodable{
    let email: String
    let password: String
}
