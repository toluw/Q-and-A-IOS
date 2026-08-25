//
//  MarketplaceProductScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/08/2026.
//

import SwiftUI
import StoreKit

struct MarketplaceProductScreen: View {
    
    let price: Int
    @StateObject var viewModel: MarketPlaceProductViewModel = MarketPlaceProductViewModel()
    
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    @ObservedObject var navVm: MainNavViewModel
    
    var productid: String{
        "ng.qanda.purchase.\(price)"
    }
    
    var body: some View {
        VStack(){
            
            Text("Purchase Marketplace Content")
                .font(AppFont.medium(18))
                .multilineTextAlignment(.center)
                .padding(.top,20)
            
            Text("₦\(price)")
                .font(AppFont.bold(22))
               
            
            switch viewModel.state{
                
            case .loading:
                
                ProgressView("Loading payment...").padding(.top, 16)
                
                
            case .error:
                VStack(spacing: 12) {
                    
                    Image(systemName: "clock.badge.exclamationmark")
                        .font(.system(size: 40))
                    
                    Text("This price point is not available yet")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Text(
                        "We're preparing this price point for purchases. " +
                        "Please check back soon."
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                .padding(.horizontal,16)
            case .loaded(product: let product):
                ProductView(product)
                    .productViewStyle(.large)
                    .padding(.top, 20)
                    .padding(.horizontal,16)
            }
            
            Spacer()
            
            
        }.task {
            await viewModel.loadProducts(productId: productid)
        } .onChange(of: viewModel.successPaymentReference){previous, current in
            
            if let reference = viewModel.successPaymentReference{
                
                print(
                    "Payment Success: ref.\(reference): "
                )
                paymentViewModel.paymentState = .success(reference: reference, processor: 3)
                navVm.pop()
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    
                    paymentViewModel.paymentState = .cancel
                    navVm.pop()
                    
                } label: {
                    
                        Image(systemName: "xmark")
                        
                    
                }
            }
        }
    }
    
}



#Preview {
    MarketplaceProductScreen(price: 100, paymentViewModel: PaymentViewModel(), navVm: MainNavViewModel())
}
