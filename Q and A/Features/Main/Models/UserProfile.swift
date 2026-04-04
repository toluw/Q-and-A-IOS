//
//  UserProfile.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation

struct UserProfile{
    var name: String = UserSettings.name ?? ""
    var email: String = UserSettings.email ?? ""
    var profileImage: String = UserSettings.profileImage ?? ""
    var isLoggedIn: Bool = UserSettings.isLoggedIn
    var phoneNumber: String = UserSettings.phoneNumber ?? ""
}
    

