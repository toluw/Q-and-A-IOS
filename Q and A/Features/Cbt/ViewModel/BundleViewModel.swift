//
//  BundleViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation

@MainActor
class BundleViewModel: ObservableObject {
    
    
    @Published var state = BundleState()
    
    
    private let service: CbtServiceProtocol
      
      init(service: CbtServiceProtocol = CbtService()) {
          self.service = service
      }
    
    
    
    func getBundles(
        buyerEmail: String,
        cbcId: String,
        level: String,
        bundleId: String?,
        offer: Offer
    )async{
        
        
        
        state.isLoading = true
        state.errorMessage = nil
        
        
            do{
              
                let response = try await service.getBundles(buyerEmail: buyerEmail, level: level, cbcId: cbcId)
                state.isLoading = false
                
                let data = response.data.data
                
                if(data.isEmpty){
                    state.isDataEmpty = true
                }else{
                  
                    setStaticText(offer: offer, bundleData: response.data)
                   initBundleData(bundleId: bundleId, userBundleList: data)
                    updateDynamicContent(bundleType: offer.offerType)
                    
                    
                }
              
                
                } catch {
                
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        
        
    }
    
    
    func updateDynamicContent(bundleType: String){
        
    }
    
    func setStaticText(offer: Offer, bundleData: BundledData){
        state.title = offer.title
        state.description = bundleData.description
        state.selectSubjectTxt = "Select \(offer.offerType)s"
    }
    
    
    
    func initBundleData(bundleId: String?, userBundleList: [UserBundle]) {
        let selectedBundle = bundleId.flatMap { id in
            userBundleList.first { $0.bundleId == id }
        }

        if let selectedBundle = selectedBundle {
            state.items = [
                BundleWithSelection(
                    userBundle: selectedBundle,
                    isSelected: true
                )
            ] + userBundleList
                .filter { $0.bundleId != selectedBundle.bundleId }
                .map {
                    BundleWithSelection(
                        userBundle: $0,
                        isSelected: false
                    )
                }
        } else {
            state.items = userBundleList.map {
                BundleWithSelection(
                    userBundle: $0,
                    isSelected: false
                )
            }
        }
    }
    
    
    
    
    
    
}
