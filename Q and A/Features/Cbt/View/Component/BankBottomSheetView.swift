//
//  BankBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 20/10/2026.
//

import SwiftUI

struct BankBottomSheetView: View {
    
    
    @StateObject var viewModel: BankViewModel = .init()
    @State private var searchText = ""
    let onBankClicked: (String) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            DragIndicator()

            Text("Select Bank")
                .font(AppFont.regular(16))
                .padding(.top, 20)

            TextField("Search banks", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.horizontal, 20)
                .accessibilityLabel("Search banks")

            ScrollView {
                LazyVStack(spacing: 0){
                
                    switch viewModel.state{
                    
                    case .loading:
                    
                        ProgressView("Loading banks…")
                            .padding(.top, 60)
                            .frame(maxWidth: .infinity)
                    case .error(let mes):
                        ErrorView(message: mes) {
                           viewModel.getAllBanks()
                        }
                        .padding(.vertical, 32)
                    case .empty:
                        EmptyStateView(title: "No banks at the moment")
                            .padding(.top, 48)
                            .frame(maxWidth: .infinity)
                    case .loaded(let data):
                        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                        let banks = query.isEmpty ? data : data.filter {
                            $0.name.localizedStandardContains(query)
                        }

                        if banks.isEmpty {
                            EmptyStateView(title: "No banks found")
                                .padding(.top, 48)
                                .frame(maxWidth: .infinity)
                        } else {
                            ForEach(banks) { item in
                                ItemView(item: item.name, onItemClicked: {
                                    onBankClicked(item.name)
                                })
                            }
                            .padding(.top, 20)
                        }
                    }
                }
            }
        }
        .onAppear{
            viewModel.getAllBanks()
        }
        
        
    }
    
}

#Preview {
    BankBottomSheetView(onBankClicked: {_ in 
        
    })
}
