//
//  SocialSignupResponse.swift
//  Q and A
//
//  Created by GIGL-PC on 14/08/2026.
//

import Foundation

struct SocialSignupResponse: Codable{
    let status: Bool
    let message: String
    let data: SocialSignupData
    
}


struct SocialSignupData: Codable{
      let library: [LoginResponse.Library]?
      let name: String
      let email: String
      let phone: String
      let image: String?
      let paystackApiKey: String

      enum CodingKeys: String, CodingKey {
          case library
          case name
          case email
          case phone
          case image
          case paystackApiKey = "paystack_api_key"
      }
}
