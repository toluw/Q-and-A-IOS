//
//  CommentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 04/08/2026.
//

import SwiftUI

struct CommentScreen: View {
    
    @Binding var post: Post?
    let postId: String
    let showKeyPad: Bool
    @StateObject private var viewModel = CommentViewModel()
    
    
    var body: some View {
        ZStack{
            
            VStack{
                
                
                VStack{
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            
                            if post != nil {
                                CommentPostView(
                                    post: Binding(
                                        get: { post! },
                                        set: { post = $0 }
                                    ),
                                    onLikeClicked: {}
                                ).padding(.horizontal, 16)
                            }
                            
                            Rectangle()
                                .fill(Color("FaintGrey"))
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                                .padding(.top,8)
                            
                            
                            content
                        }
                        
                    }
                    
                    Spacer()
                    
                    
                }.frame(maxWidth: .infinity)
                    .background(Color("post_bg"))
                    
                
                if(viewModel.state.showBlockedLoader){
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    await viewModel.refresh(postId: postId, buyerEmail: UserSettings.email ?? "")
                }
                .task {
                    await viewModel.loadInitial(postId: postId, buyerEmail: UserSettings.email ?? "")
                }
                .toastBanner(toast: $viewModel.state.responseMessage)
                .toolbar {
                    
                    // Title
                    ToolbarItem(placement: .principal) {
                        Text("Post").font(AppFont.regular(18))
                    }
                    
                    
                }
        }
        
        
      
    }
    
    
    @ViewBuilder
    private var content: some View {
        
        ZStack{
            
            if viewModel.state.isLoading && viewModel.state.items.isEmpty {
                initialLoadingView
                
            } else if let error = viewModel.state.errorMessage, viewModel.state.items.isEmpty {
                
                
                ErrorView(message: error, onRetry: {
                    Task { await viewModel.refresh(postId: postId, buyerEmail: UserSettings.email ?? "")
                        
                    }
                })
                
                
                
            } else if viewModel.state.isEmpty {
                
                Text("Be the first to comment on this post")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(AppFont.regular(14))
                    .foregroundColor(Color("empty"))
                    .padding(.top,40)
                
                
            } else {
                commentItems
            }
            
        }.frame(maxWidth: .infinity)
            .padding(.horizontal,16)
        
        
      
    }
    
    
    
    @ViewBuilder
    private var commentItems: some View {
        ForEach($viewModel.state.items) { $comment in
            CommentView(comment: $comment, onClick: {
                
            }, onOptionClicked: {
                
            }, onReplyClicked: {
                
            }, onLikeClicked: {
                
            })
            .task {
                await viewModel.loadMoreIfNeeded(postId: postId, buyerEmail: UserSettings.email ?? "", currentItem: comment)
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
                    Task { await viewModel.loadMore(postId: postId, buyerEmail: UserSettings.email ?? "") }
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
        CommentScreenPreviewWrapper(post: Post.preview, postId: "3")
    }
    
    struct CommentScreenPreviewWrapper: View{
        
        @State var post: Post?
        let postId: String
        
        init(post: Post, postId: String) {
            self.post = post
            self.postId = postId
        }
        
        var body: some View {
            CommentScreen(post: $post, postId: postId, showKeyPad: true)
        }
        
        
    }

