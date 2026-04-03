//
//  DeviceManager.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation
import UIKit


class DeviceManager {
    
    static let shared = DeviceManager()
    
    private let key = "device_id"
    
    func getDeviceId() -> String {
        if let saved = KeychainHelper.get(key: key) {
            return saved
        } else {
            let newId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            KeychainHelper.save(key: key, value: newId)
            return newId
        }
    }
}
