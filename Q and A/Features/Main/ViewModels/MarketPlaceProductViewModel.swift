//
//  MarketPlaceProductViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 25/08/2026.
//

import Foundation
import StoreKit
import Observation



@MainActor
class MarketPlaceProductViewModel: ObservableObject{
    
    @Published var state: ProductLoadState = .loading
    var currentProductId: String? = nil
    var successPaymentReference: String? = nil
    
    private var transactionListener: Task<Void, Never>?

       init() {
           transactionListener = listenForTransactions()
       }

       deinit {
           transactionListener?.cancel()
       }
    
    
    func loadProducts(productId: String) async{
        
        do{
            currentProductId = productId
            state = .loading
            let products = try await Product.products(for: [productId])
            state = .loaded(products[0])
            
            
        } catch{
            print("Failed to load products: \(error)")
            state = .error
        }
    }
    
    private func listenForTransactions() -> Task<Void, Never> {

        Task.detached { [weak self] in

            for await result in StoreKit.Transaction.updates {

                await self?.handleTransaction(result)
            }
        }
    }
    
    private func handleTransaction(
        _ result: VerificationResult<StoreKit.Transaction>
    ) async {

        switch result {

        case .verified(let transaction):
            
            if(transaction.productID == currentProductId){
                
                
               
                await transaction.finish()
                
                successPaymentReference = String(transaction.id)
                
                
                
                
            }

            

            

        case .unverified(let transaction, let error):

            print(
                "Unverified transaction: \(transaction.id), error: \(error)"
            )
        }
    }
    
    
    
    
    
}
