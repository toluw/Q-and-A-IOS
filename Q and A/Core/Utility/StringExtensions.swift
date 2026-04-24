//
//  String.swift
//  Q and A
//
//  Created by GIGL-PC on 04/04/2026.
//

import Foundation


extension String{
    
    func isValidEmail() -> Bool {
            NSPredicate(
                format: "SELF MATCHES %@",
                "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            ).evaluate(with: self)
        }
    
    func capitalizeWords() -> String {
            return self
                .lowercased()
                .split(separator: " ")
                .map { word in
                    word.prefix(1).uppercased() + word.dropFirst()
                }
                .joined(separator: " ")
        }
}
