//
//  ReplyScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import SwiftUI

struct ReplyScreen: View {
    
    let comment: Comment?
    
    let commentId: String
    let showKeyPad: Bool
    @StateObject private var viewModel = ReplyViewModel()
    
    
    var body: some View {
        ZStack{
           
            VStack{
                ScrollViewReader { proxy in
                    ScrollView {
                        
                        LazyVStack(spacing: 15) {
                            
                            if viewModel.commentState != nil {
                                
                                ReplyCommentView(comment: Binding(
                                    get: { viewModel.commentState! },
                                    set: { viewModel.commentState = $0 }
                                ), onLikeClicked: {
                                   let likeCommentBody = LikeCommentBody(comment_id: commentId, email: UserSettings.email ?? "")
                                }).padding(.horizontal, 16)
                                
                               
                            }
                            
                            Rectangle()
                                .fill(Color("FaintGrey"))
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                                .padding(.top,8)
                                .id("content")
                            
                            
                            content
                                
                        }
                        
                    }.onAppear{
                        if(showKeyPad){
                            scrollToContent(proxy: proxy)
                            
                        }
                            
                            if(comment != nil){
                                viewModel.commentState = comment
                            }else{
                                viewModel.getCommentById(commentId: commentId, email: UserSettings.email ?? "")
                            }
                            
                        
                        
                    }
                    
                }
                
            }
            
            if(viewModel.state.showOptionSheet){
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.state.showOptionSheet = false
                    }
                
                VStack{
                    
                   Spacer()
                    
                    OptionBottomSheet(items: [EDIT,DELETE], onItemClicked: {option in
                        viewModel.state.showOptionSheet = false
                        if(option == EDIT){
                            viewModel.state.isEdit = true
                            viewModel.state.requestFocus = true
                            viewModel.state.content = viewModel.reply?.content ?? ""
                            viewModel.state.quote = nil
                            viewModel.state.label = "Add Reply"
                            
                        }else if(option == DELETE){
                            
                            deleteReply()
                        }
                        
                        
                    })
                    .transition(.scale)
                    
                }

                
            }
            
        } .frame(maxWidth: .infinity, maxHeight: .infinity)
            .refreshable {
                await viewModel.refresh(commentId: commentId, buyerEmail: UserSettings.email ?? "")
            }
            .task {
                await viewModel.loadInitial(commentId: commentId, buyerEmail: UserSettings.email ?? "")
            }
            .toastBanner(toast: $viewModel.state.responseMessage)
            .toolbar {
                
                // Title
                ToolbarItem(placement: .principal) {
                    Text("Post").font(AppFont.regular(18))
                }
                
                
            }
        .background(Color("post_bg"))
        
    }
    
    func scrollToContent(proxy: ScrollViewProxy){
        DispatchQueue.main.async {
            proxy.scrollTo("content", anchor: .bottom)
              }
    }
    
    
    @ViewBuilder
    private var content: some View {
        
        
            
            if viewModel.state.isLoading && viewModel.state.items.isEmpty {
                initialLoadingView.padding(.horizontal,16)
                
            } else if let error = viewModel.state.errorMessage, viewModel.state.items.isEmpty {
                
                
                ErrorView(message: error, onRetry: {
                    Task { await viewModel.refresh(commentId: commentId, buyerEmail: UserSettings.email ?? "")
                        
                    }
                }).padding(.horizontal,16)
                
                
                
            } else if viewModel.state.isEmpty {
                
                Text("Be the first to reply on this comment")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(AppFont.regular(14))
                    .foregroundColor(Color("empty"))
                    .padding(.top,40)
                    .padding(.horizontal,16)
                
                
                
            } else {
                replyItems.padding(.horizontal,16)
            }
            
        
        
        
      
    }
    
    
    @ViewBuilder
    private var replyItems: some View {
        ForEach($viewModel.state.items) { $reply in
            
            
            ReplyView(reply: $reply,
                      onOptionClicked: {
                
                viewModel.reply = reply
                viewModel.state.showOptionSheet = true
                viewModel.state.requestFocus = true
                
            }, onReplyClicked: {
                
                viewModel.state.quote = reply
                viewModel.state.label = "Reply \(reply.user.name)"
                
                
            }, onLikeClicked: {
                
                let likeReplyBody = LikeReplyBody(reply_id: reply.id, email: UserSettings.email ?? "")
                viewModel.likeReply(likeReplyBody: likeReplyBody)
                
            })
            .task {
                await viewModel.loadMoreIfNeeded(commentId: commentId, buyerEmail: UserSettings.email ?? "", currentItem: reply)
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
                    Task { await viewModel.loadMore(commentId: commentId, buyerEmail: UserSettings.email ?? "") }
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
    
    
    func scrollToBottom(proxy: ScrollViewProxy){
        DispatchQueue.main.async {
                  proxy.scrollTo("bottom", anchor: .bottom)
              }
    }
    
    private func deleteReply(){
        
            showErrorMessage(message: "Are you sure you want to delete this reply" , actionTitle: "Delete", showCancel: true, action: {
                
                if let reply = viewModel.reply{
                    
                    let deleteReplyBody = DeleteReplyBody(reply_id: reply.id, reason: "", is_admin: false)
                    
                    viewModel.deleteReply(deleteReplyBody: deleteReplyBody, commentId: commentId, buyerEmail: UserSettings.email ?? "")
                    
                   
                    
                }
                
            })
        
    }
}

#Preview {
    ReplyScreen(comment: Comment.preview, commentId: "3", showKeyPad: true)
}
