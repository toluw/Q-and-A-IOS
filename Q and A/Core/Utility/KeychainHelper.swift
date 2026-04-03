//
//  KeychainHelper.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation

class KeychainHelper {
    
    static func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr {
            let data = dataTypeRef as! Data
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
}
