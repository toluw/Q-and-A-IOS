//
//  CbtPostScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import SwiftUI

struct CbtPostScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    let examId: String
    let liveExam: LiveExam?
    @StateObject private var viewModel = CbtPostViewModel()
    
    
    var body: some View {
        VStack{
            VStack{
                ScrollView {
                    LazyVStack(spacing: 15) {
                        // Always shown first — for loading, error, empty, and list states —
                        // and scrolls naturally with the list once posts are visible.
                        if let exam = liveExam{
                            DiscussionSolutionView(liveExam: exam).padding(.top, 12)
                        }

                        content
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                SocialPostInputView(label: "Join the conversation..", onSubmit: {text in
                    
                }, onSelectImage: {})
            }
            .frame(maxWidth: .infinity)
            .background(Color("post_bg"))
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .refreshable {
                await viewModel.refresh(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
            }
            .task {
                await viewModel.loadInitial(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
            }
            .toolbar {
                
                // Title
                ToolbarItem(placement: .principal) {
                    Text("Discussion").font(AppFont.regular(18))
                }
                
                
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.state.isLoading && viewModel.state.items.isEmpty {
            initialLoadingView

        } else if let error = viewModel.state.errorMessage, viewModel.state.items.isEmpty {
            
            
            ErrorView(message: error, onRetry: {
                Task { await viewModel.refresh(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
                    
                }
            })
            
        

        } else if viewModel.state.isEmpty {
            
            Text("The explanation has not yet been discussed. Please take the lead. Start the discussion")
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .font(AppFont.regular(14))
                .foregroundColor(Color("empty"))
                .padding(.top,40)
            

        } else {
            postItems
        }
    }
    
    @ViewBuilder
    private var postItems: some View {
        ForEach(viewModel.state.items.indices, id: \.self) { index in
            CbtPostView(post: $viewModel.state.items[index], onClick: {}, onOptionClicked: {}, onCommentClicked: {}, onLikeClicked: {})
                .task {
                    await viewModel.loadMoreIfNeeded(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "", currentItem: viewModel.state.items[index])
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
                    Task { await viewModel.loadMore(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "") }
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
    CbtPostScreen(navVm: MainNavViewModel(), examId: "2", liveExam: LiveExam.preview)
}
