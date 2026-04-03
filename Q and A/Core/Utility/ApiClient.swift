//
//  ApiClient.swift
//  Q and A
//
//  Created by GIGL-PC on 03/04/2026.
//

import Foundation
import Moya






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
}





