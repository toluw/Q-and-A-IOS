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
    @Published var successPaymentReference: String? = nil
    @Published var isPurchasing = false
    
    private var transactionListener: Task<Void, Never>?

       init() {
           transactionListener = listenForTransactions()
       }

       deinit {
           transactionListener?.cancel()
       }
    
    
    func purchase(_ product: Product) async {
        isPurchasing = true
        defer { isPurchasing = false }
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    await transaction.finish()
                    successPaymentReference = String(transaction.id)
                }
            case .userCancelled, .pending:
                break
            @unknown default:
                break
            }
        } catch {
            print("Purchase failed: \(error)")
            state = .error
        }
    }
    
    
    func loadProducts(productId: String) async{
        
        do{
            currentProductId = productId
            state = .loading
            let products = try await Product.products(for: [productId])
            
            if(products.isEmpty){
                state = .error
            }else{
                state = .loaded(products[0])
            }
            
            
            
        } catch{
            print("Failed to load products: \(error)")
            state = .error
        }
    }
    
    private func listenForTransactions() -> Task<Void, Never> {
        Task { [weak self] in
            for await result in StoreKit.Transaction.updates {
                guard let self else { break }
                await self.handleTransaction(result)
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
                

                print(
                    "Verified transaction: \(transaction.id),transaction => \(transaction)"
                )
                
                successPaymentReference = String(transaction.id)
                
                
                
                
            }else{
                
                print(
                    "Verified but wrong transaction: \(transaction.id), product id = \(transaction.productID), transaction => \(transaction)"
                )
            }

            

            

        case .unverified(let transaction, let error):

            print(
                "Unverified transaction: \(transaction.id), error: \(error)"
            )
        }
    }
    
    
    
    
    
}
