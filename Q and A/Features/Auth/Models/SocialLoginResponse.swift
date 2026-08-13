//
//  SocialLoginResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 13/08/2026.
//

import Foundation

struct SocialLoginResponse: Codable {
    let status: Bool
    let message: String
    let data: SocialUserData
}

struct SocialUserData: Codable{
    let isRegistered: Bool
    let library: [LoginResponse.Library]?
      let name: String?
      let email: String?
      let phone: String?
      let image: String?
      let paystackApiKey: String

      enum CodingKeys: String, CodingKey {
          case isRegistered = "is_registered"
          case library
          case name
          case email
          case phone
          case image
          case paystackApiKey = "paystack_api_key"
      }
}
