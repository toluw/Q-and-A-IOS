//
//  UserSettings.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import Foundation

struct UserSettings {

    static var hasLaunchedBefore: Bool {
        get { UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.hasLaunchedBefore) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.hasLaunchedBefore) }
    }
    
    static var isLoggedIn: Bool{
        get { UserDefaults.standard.bool(forKey: AppConstants.UserDefaultsKeys.isLoggedIn) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.isLoggedIn) }
    }
    
    static var name: String?{
        get { UserDefaults.standard.string(forKey: AppConstants.UserDefaultsKeys.name) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.name) }
    }
    
    static var email: String?{
        get { UserDefaults.standard.string(forKey: AppConstants.UserDefaultsKeys.email) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.email) }
    }
    
    static var profileImage: String?{
        get { UserDefaults.standard.string(forKey: AppConstants.UserDefaultsKeys.profileImage) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.profileImage) }
    }
    
    static var phoneNumber: String?{
        get { UserDefaults.standard.string(forKey: AppConstants.UserDefaultsKeys.phoneNumber) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.phoneNumber) }
    }
    
    static var token: String?{
        get { UserDefaults.standard.string(forKey: AppConstants.UserDefaultsKeys.token) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.token) }
    }
    
    static var paystackApiKey: String?{
        get { UserDefaults.standard.string(forKey: AppConstants.UserDefaultsKeys.paystackApiKey) }
        set { UserDefaults.standard.set(newValue, forKey: AppConstants.UserDefaultsKeys.paystackApiKey) }
    }

   }
