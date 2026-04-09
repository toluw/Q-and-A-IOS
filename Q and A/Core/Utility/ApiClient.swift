//
//  ApiClient.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation
import Moya
import Alamofire






class APIClient<T: TargetType> {
    
    private let provider: MoyaProvider<T>
    
    init(provider: MoyaProvider<T> = MoyaProvider<T>(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }
    
    func request<D: Decodable>(
        _ target: T,
        responseType: D.Type,
        errorParser: ((Data) -> String?)? = nil
    ) async throws -> D {
        
        return try await withCheckedThrowingContinuation { continuation in
            
            provider.request(target) { result in
                
                switch result {
                case .success(let response):
                    self.handleResponse(
                        response,
                        continuation: continuation,
                        errorParser: errorParser
                    )
                    
                case .failure(let error):
                    self.handleError(error, continuation: continuation)
                }
            }
        }
    }
    
    
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
            
            continuation.resume(throwing: mapError(error))
            
            
          /*
            
           switch error {
                
            case .underlying(let underlyingError, _):
                
             //   print("Underlying error:", underlyingError)
                
                let nsError = underlyingError as NSError
                
                print("NSError:", nsError)
               
                print ("Error Cod", nsError.code)
                
                switch nsError.code {
                case NSURLErrorNotConnectedToInternet,
                    NSURLErrorNetworkConnectionLost,
                    NSURLErrorCannotFindHost,
                    NSURLErrorUserAuthenticationRequired,
                    NSURLErrorCannotConnectToHost: do{
                    print("network_error", "Not internet")
                    continuation.resume(throwing: AppError.noInternet)
                }
                    
               case NSURLErrorTimedOut: do{
                    print("network_error", "Not timeout")
                    continuation.resume(throwing: AppError.timeout)
                }
                    
                    
                default: do {
                    print("network_error", "Not network")
                    continuation.resume(throwing: AppError.unknown)
                }
                    
                }
                
                
            default: do {
                print("network_error", "Not underlying")
                continuation.resume(throwing: AppError.unknown)
            }
                
            }
            
            */
       
        }
    
    
    private func mapError(_ error: MoyaError) -> AppError {
        
        switch error {
            
        case .underlying(let underlyingError, _):
            
            // ✅ Step 1: Handle Alamofire AFError
            if let afError = underlyingError as? AFError {
                
                if case let .sessionTaskFailed(innerError) = afError {
                    return mapNSError(innerError as NSError)
                }
                
                return .unknown
            }
            
            // ✅ Step 2: Handle direct NSError
            return mapNSError(underlyingError as NSError)
            
        case .statusCode(let response):
            return .server("Server error (\(response.statusCode))")
            
        default:
            return .unknown
        }
    }
    
    
    private func mapNSError(_ error: NSError) -> AppError {
        
        guard error.domain == NSURLErrorDomain else {
            return .unknown
        }
        
        switch error.code {
            
        case NSURLErrorNotConnectedToInternet,
             NSURLErrorNetworkConnectionLost,
             NSURLErrorCannotFindHost,
             NSURLErrorCannotConnectToHost:
            return .noInternet
            
        case NSURLErrorTimedOut:
            return .timeout
            
        default:
            return .unknown
        }
    }
   
    
}





