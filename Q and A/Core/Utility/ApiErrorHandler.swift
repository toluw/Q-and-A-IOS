//
//  ApiErrorHandler.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation
import Moya




extension APIClient {
    
    
    func handleResponse<D: Decodable>(
            _ response: Response,
            continuation: CheckedContinuation<D, Error>,
            errorParser: ((Data) -> String?)?
        ) {
            
            // ✅ 1. Check HTTP status code FIRST
            guard (200...299).contains(response.statusCode) else {
                
                let message = errorParser?(response.data)
                
                continuation.resume(
                    throwing: AppError.server(
                        message ?? "Server error (\(response.statusCode))"
                    )
                )
                return
            }
            
            // ✅ 2. Decode success response
            do {
                let decoded = try JSONDecoder().decode(D.self, from: response.data)
                continuation.resume(returning: decoded)
                
            } catch {
                continuation.resume(throwing: AppError.decoding)
            }
        }
    
    
    
    func handleError<D>(
            _ error: MoyaError,
            continuation: CheckedContinuation<D, Error>
        ) {
            
            switch error {
                
            case .underlying(let nsError as URLError, _):
                
                switch nsError.code {
                case .notConnectedToInternet:
                    continuation.resume(throwing: AppError.noInternet)
                    
                case .timedOut:
                    continuation.resume(throwing: AppError.timeout)
                    
                default:
                    continuation.resume(throwing: AppError.unknown)
                }
                
            default:
                continuation.resume(throwing: AppError.unknown)
            }
        }
    
    
    
}
