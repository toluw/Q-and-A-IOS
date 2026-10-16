//
//  ParentCatViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 16/04/2026.
//

import Foundation

@MainActor
class ParentCatViewModel: ObservableObject {
    
    

    
    @Published var state = ParentCatState()
    @Published var showLogin: Bool = false
    
    var hasLoadData = false
    
    var offer: Offer? = nil
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    func getParentCatData(level: String?, cbcId: String?, isMock: String, isActive: String = "1") async{
        
        if(!hasLoadData){
            state.isLoading = true
        }
    
        state.errorMessage = nil
        
        
            do{
              
                let response = try await service.getParentCategories(level: level, cbcId: cbcId, isActive: isActive, isMock: isMock)
                state.isLoading = false
                state.parentCatData = response.data
                state.defaultData = response.data
                hasLoadData = true
                
                } catch {
                
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        
        
    }
    
    
    func getParentBundleId(cbcId: String, level: String){
        state.showBlockedLoader = true
        
        Task{
            do{
                let response = try await service.getParentBundleId(level: level, cbcId: cbcId)
                state.showBlockedLoader = false
               if let activeOffer = offer{
                   showBundleBottomSheet(bundleId: response.data?.bundleId, offer: activeOffer)
                }
                
                
            }catch{
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.getParentBundleId(cbcId: cbcId, level: level)
                })
            }
        }
        
        
    }
    
    
    
    func showBundleBottomSheet(bundleId: String?, offer: Offer){
        state.bundleBottomSheetOffer = offer
        state.bundleBottomSheetBundleId = bundleId
        state.showBundleBottomSheet = true
    }
    
    
    
}

