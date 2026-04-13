//
//  MainCbtViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import Foundation

@MainActor
class MainCbtViewModel: ObservableObject{
    
    @Published var state = MainCbtState()
    
    private let storageKey = "home_data"
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    func loadData() {
           // 1. Try local storage
           if let cached: [DataModel] = LocalStore.shared.get([DataModel].self, forKey: storageKey) {
               print("Loaded from local")
               state.items = cached
               fetchFromApi(isCacheAvailable: true)
           } else {
               print("Fetching from API")
               fetchFromApi(isCacheAvailable: false)
           }
       }
    
    private func fetchFromApi(isCacheAvailable: Bool){
        
        state.errorMessage = nil
        
        if(!isCacheAvailable){
            state.isLoading = true
        }
        
        
        Task {
            do {
                
              
                
                let response = try await service.getParentCategories(level: nil, cbcId: nil, isActive: "1", isMock: "0")
                
               
                state.isLoading = false
                
                if(!isCacheAvailable){
                    state.items = response.data
                }
                
                LocalStore.shared.save(response.data, forKey: storageKey)
                
                
            } catch {
                state.isLoading = false
                if(!isCacheAvailable){
                    state.errorMessage =  error.localizedDescription
                }
                
            }
        }
        
    }
    
}
