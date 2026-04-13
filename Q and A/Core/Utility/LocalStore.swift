//
//  LocalStore.swift
//  Q and A
//
//  Created by GIGL-PC on 10/04/2026.
//

import Foundation

class LocalStore {
    
    static let shared = LocalStore()
    
    private func fileURL(key: String) -> URL {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return doc.appendingPathComponent("\(key).json")
    }
    
    func save<T: Codable>(_ value: T, forKey key: String) {
        let url = fileURL(key: key)
        do {
            let data = try JSONEncoder().encode(value)
            try data.write(to: url)
        } catch {
            print("Save error:", error)
        }
    }
    
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        let url = fileURL(key: key)
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Read error:", error)
            return nil
        }
    }
    
    func delete(key: String) {
        let url = fileURL(key: key)
        try? FileManager.default.removeItem(at: url)
    }
}
