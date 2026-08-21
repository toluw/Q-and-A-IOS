//
//  UserPaymentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import SwiftUI

struct UserPaymentScreen: View {
    
    
    @StateObject private var viewModel = UserPaymentsViewModel()
    @ObservedObject var navVm: MainNavViewModel
    
    
    var body: some View {
        
        ZStack{
            
           
            
            ScrollView{
              
                LazyVStack(spacing: 16){
                    
                    content
                    
                }
                
            }.padding(.top, 24)
            
            if(viewModel.state.showLoader){
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView()
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("list_bg"))
            .refreshable {
                await viewModel.refresh()
            }
            .task {
                await viewModel.loadInitial()
            }
            .toolbar {
                
                // Title
                ToolbarItem(placement: .principal) {
                    Text("Payment History").font(AppFont.regular(18))
                }
                
                
            }
        
    }
    
    
    @ViewBuilder
    private var content: some View {
        
        
            
            if viewModel.state.isLoading && viewModel.state.items.isEmpty {
                initialLoadingView.padding(.horizontal,16)
                
            } else if let error = viewModel.state.errorMessage, viewModel.state.items.isEmpty {
                
                
                ErrorView(message: error, onRetry: {
                    Task { await viewModel.refresh()
                        
                    }
                }).padding(.horizontal,16)
                
                
                
            } else if viewModel.state.isEmpty {
                
                Text("You have not made payments yet")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(AppFont.regular(14))
                    .foregroundColor(Color("empty"))
                    .padding(.top,40)
                    .padding(.horizontal,16)
                
                
                
            } else {
                paymentItems.padding(.horizontal,16)
            }
            
        
        
        
      
    }
    
    @ViewBuilder
    private var paymentItems: some View {
        ForEach($viewModel.state.items) { $payment in
            
            
            PaymentCardView(payment: payment, onClick: {
                
            })
            .task {
                await viewModel.loadMoreIfNeeded(currentItem: payment)
            }
        }
        
        paginationFooter
    }
    
    
    private var initialLoadingView: some View {
        ProgressView()
            .padding(.top, 24)
            .frame(maxWidth: .infinity)
    }
    
    
    @ViewBuilder
    private var paginationFooter: some View {
        if viewModel.state.isLoadingMore {
            ProgressView()
                .padding()
                .frame(maxWidth: .infinity)
            
        } else if let error = viewModel.state.loadMoreErrorMessage {
            VStack(spacing: 8) {
                Text(error)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button {
                    Task { await viewModel.loadMore() }
                } label: {
                    Text("Retry")
                        .font(.subheadline.bold())
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    UserPaymentScreen(navVm: MainNavViewModel())
}
