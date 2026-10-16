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
                    updateDynamicContent(offerType: offer.offerType)
                    
                    
                }
              
                
                } catch {
                
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        
        
    }
    
    
    func getSelectedBundles() -> [UserBundle] {
        return state.items
            .filter { $0.isSelected }
            .map { $0.userBundle }
    }
    
    func selectBundleAction(position: Int, offer: Offer){
        state.items[position].isSelected.toggle()
        updateDynamicContent(offerType: offer.offerType)
        
    }
    
    
    func checkIfCanContinue() {
        state.canContinue = state.items.contains { $0.isSelected }
    }
    
    func selectAllAction(offer: Offer){
        state.isSelectAll = true
        selectAllBundles()
        updateDynamicContent(offerType: offer.offerType)
        
    }
    
    func deselectAllAction(offer: Offer){
        state.isSelectAll = false
        deselectAllBundles()
        updateDynamicContent(offerType: offer.offerType)
    }
    
    
    
    func selectAllBundles() {
        for index in state.items.indices {
            state.items[index].isSelected = true
        }
    }

    func deselectAllBundles() {
        for index in state.items.indices {
            state.items[index].isSelected = false
        }
    }
    
    
    func updateDynamicContent(offerType: String){
        
        let numSelected = getNumSelectedBundles()
        let totalPrice = getTotalPrice()
        
        state.subjectSelectedTxt = numSelected == 1 ? "\(numSelected) \(offerType) selected" : "(numSelected) \(offerType)s selected"
        
        
        state.bundlePriceTxt = totalPrice.price.formatted(.currency(code: "NGN"))
        state.originalPriceTxt = totalPrice.originalPrice.formatted(.currency(code: "NGN"))
        
        checkIfCanContinue()
            
        
        
    }
    
    func getTotalPrice() -> BundlePrice {
        let selectedBundles = state.items.filter { $0.isSelected }

        return BundlePrice(
            price: selectedBundles.reduce(0) { $0 + $1.userBundle.price },
            originalPrice: selectedBundles.reduce(0) { $0 + $1.userBundle.originalPrice },
            discountedPrice: selectedBundles.reduce(0) { $0 + $1.userBundle.discountedPrice }
        )
    }

    func getNumSelectedBundles() -> Int {
        return state.items.filter { $0.isSelected }.count
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
