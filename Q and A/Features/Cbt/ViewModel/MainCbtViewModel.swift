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
    
    private let bgList = ["col0","col1","col2"]
    private let imageList = ["cat0","cat1","cat2"]
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    func loadData() {
           // 1. Try local storage
           if let cached: [DataModel] = LocalStore.shared.get([DataModel].self, forKey: storageKey) {
               print("Loaded from local")
               state.items = getBaseCat(data: cached, imageList: imageList, backgroundList: bgList)
               fetchFromApi(isCacheAvailable: true)
           } else {
               print("Fetching from API")
               fetchFromApi(isCacheAvailable: false)
           }
       }
    
    func getBaseCat(
        data: [DataModel],
        imageList: [String],
        backgroundList: [String]
    ) -> [BaseCat] {
        
        var result: [BaseCat] = []
        
        var imageIndex = 0
        var backgroundIndex = 0
        
        for dt in data {
            
            let baseCat = BaseCat(
                data: dt,
                image: imageList[imageIndex],
                background: backgroundList[backgroundIndex]
            )
            
            result.append(baseCat)
            
            // Cycle image index
            if imageIndex < imageList.count - 1 {
                imageIndex += 1
            } else {
                imageIndex = 0
            }
            
            // Cycle background index
            if backgroundIndex < backgroundList.count - 1 {
                backgroundIndex += 1
            } else {
                backgroundIndex = 0
            }
        }
        
        return result
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
                    state.items =  getBaseCat(data: response.data, imageList: imageList, backgroundList: bgList)
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
