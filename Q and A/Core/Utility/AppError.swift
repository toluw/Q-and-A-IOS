//
//  AppError.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation

enum AppError: LocalizedError {
    case noInternet
    case timeout
    case server(String)
    case decoding
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network."
        case .timeout:
            return "Request timed out. Please try again."
        case .server(let message):
            return message
        case .decoding:
            return "Failed to process server response"
        case .unknown:
            return "Something went wrong"
        }
    }
}
