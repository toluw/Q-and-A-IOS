//
//  CbtHistoryScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 18/08/2026.
//

import SwiftUI

struct CbtHistoryScreen: View {
    
    @StateObject private var viewModel = CbtHistoryViewModel()
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
                    Text("CBT History").font(AppFont.regular(18))
                }
                
                
            }
            .onChange(of: viewModel.state.liveExamDataList){previous, current in
                
                if let data = current{
                    
                    if let cbtHistory = viewModel.cbtHistory{
                        
                        let examResultData = viewModel.getExamResultData(cbtHistory:cbtHistory, data:data)
                        
                        if(examResultData.examResult.disableReview){
                            showNoticeMessage(message: "Fan Quiz Result details coming soon.", actionTitle: "Dismiss", showCancel: false, action: {})
                        }else{
                            navVm.navigate(route: .resultScreen(examResultData: examResultData))
                        }
                        
                        
                    }
                    
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
                
                Text("You have not attempted CBT yet")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(AppFont.regular(14))
                    .foregroundColor(Color("empty"))
                    .padding(.top,40)
                    .padding(.horizontal,16)
                
                
                
            } else {
                historyItems.padding(.horizontal,16)
            }
            
        
        
        
      
    }
    
    
    @ViewBuilder
    private var historyItems: some View {
        ForEach($viewModel.state.items) { $cbtHistory in
            
            
            CbtHistoryView(cbtHistory: cbtHistory, onViewResult: {
                viewModel.cbtHistory = cbtHistory
                viewModel.getLiveExam(resultId: cbtHistory.id)
                
            })
            .task {
                await viewModel.loadMoreIfNeeded(currentItem: cbtHistory)
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
    CbtHistoryScreen(navVm: MainNavViewModel())
}
