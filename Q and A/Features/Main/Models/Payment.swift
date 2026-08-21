//
//  Payment.swift
//  Q and A
//
//  Created by GIGL-PC on 20/08/2026.
//

import Foundation

struct Payment: Codable, Equatable, Identifiable, Hashable {
    let id: String
    let email: String
    let price: String
    let isAndroid: String
    let processor: String
    let type: String
    let reference: String
    let createdAt: String
    let name: String?
    let paymentProcessor: String
    
    static let preview = Payment(id: "3", email: "oke@gmail.com", price: "500", isAndroid: "1", processor: "1", type: "cbt", reference: "38439028", createdAt: "2023-07-15 13:02:32", name: "Tolu Oke", paymentProcessor: "Paystack")

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case price
        case isAndroid = "is_android"
        case processor
        case type
        case reference
        case createdAt = "created_at"
        case name
        case paymentProcessor = "payment_processor"
    }
}
