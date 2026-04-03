//
//  JsonExtractor.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation



extension Data {
    
    /// Extracts a String value for a given key from JSON response
    func jsonString(forKey key: String) -> String? {
        let json = try? JSONSerialization.jsonObject(with: self) as? [String: Any]
        return json?[key] as? String
    }
}
