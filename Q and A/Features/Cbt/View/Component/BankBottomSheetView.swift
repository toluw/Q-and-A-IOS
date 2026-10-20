//
//  BankBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import SwiftUI

struct BankBottomSheetView: View {
    
    
    @StateObject var viewModel: BankViewModel = .init()
    let onBankClicked: (String) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0){
                
                switch viewModel.state{
                    
                case .loading:
                    
                    ProgressView("Loading earnings…")
                        .padding(.top, 48)
                        .frame(maxWidth: .infinity)
                case .error(let mes):
                    ErrorView(message: mes) {
                        Task { await viewModel.getAllBanks() }
                    }
                    .padding(.vertical, 32)
                case .empty:
                    EmptyStateView(title: "No banks at the moment")
                        .padding(.top, 48)
                        .frame(maxWidth: .infinity)
                case .loaded(let data):
                    ForEach(data){item in
                        ItemView(item: item.name, onItemClicked: {
                            
                            onBankClicked(item.name)
                            
                            
                        })
                    }.padding(.top, 20)
                }
            }
        }
        .task {
            await viewModel.getAllBanks()
        }
        
    }
    
}

#Preview {
    BankBottomSheetView(onBankClicked: {_ in 
        
    })
}
