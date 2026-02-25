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

   }
