//
//  CommentScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 04/08/2026.
//

import SwiftUI

struct CommentScreen: View {
    
    let post: Post?
    
    let postId: String
    let showKeyPad: Bool
    @StateObject private var viewModel = CommentViewModel()
    
    
    var body: some View {
        ZStack{
            
        
                
                VStack{
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 15) {
                                
                                if viewModel.postState != nil {
                                    CommentPostView(
                                        post: Binding(
                                            get: { viewModel.postState! },
                                            set: { viewModel.postState = $0 }
                                        ),
                                        onLikeClicked: {
                                            
                                            let postBody = PostBody(post_id: postId, email: UserSettings.email ?? "")
                                            
                                            viewModel.likePost(postBody: postBody)
                                            
                                        }
                                            
                                            
                                            
                                    ).padding(.horizontal, 16)
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
                                if(post != nil){
                                    viewModel.postState = post
                                }else{
                                    viewModel.getPostById(postId: postId, email: UserSettings.email ?? "")
                                }
                                
                            }
                            
                        }
                    }
                    
                    Spacer()
                    
                    SocialPostInputView(text: $viewModel.state.content, label: "Add Comment", requestFocus: $viewModel.state.requestFocus, onSubmit: {text, base64Image in
                       
                        
                        if(viewModel.state.isEdit){
                            
                            let updateCommentBody = UpdateCommentBody(content: text, comment_id: viewModel.comment?.id ?? "", image: base64Image)
                            
                            viewModel.updateComment(updateCommentBody: updateCommentBody, postId: postId, buyerEmail: UserSettings.email ?? "")
                            
                            
                        }else{
                            
                            let createCommentBody = CreateCommentBody(post_id: postId, email: UserSettings.email ?? "", content: text, image: base64Image)
                            
                            viewModel.createComment(createCommentBody: createCommentBody, postId: postId, buyerEmail: UserSettings.email ?? "")
                            
                            
                        }
                        
                        viewModel.state.content = ""
                        viewModel.state.isEdit = false
                        
                        
                        
                    })
                    
                    
                }.frame(maxWidth: .infinity)
                    
                    
                
                if(viewModel.state.showBlockedLoader){
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
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
                                viewModel.state.content = viewModel.comment?.content ?? ""
                                
                            }else if(option == DELETE){
                                
                                deleteComment()
                            }
                            
                            
                        })
                        .transition(.scale)
                        
                    }

                    
                }
                
                
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    Task { await viewModel.refresh(postId: postId, buyerEmail: UserSettings.email ?? "")
                        
                    }
                }).padding(.horizontal,16)
                
                
                
            } else if viewModel.state.isEmpty {
                
                Text("Be the first to comment on this post")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .font(AppFont.regular(14))
                    .foregroundColor(Color("empty"))
                    .padding(.top,40)
                    .padding(.horizontal,16)
                
                
                
            } else {
                commentItems.padding(.horizontal,16)
            }
            
        
        
        
      
    }
    
    
    
    @ViewBuilder
    private var commentItems: some View {
        ForEach($viewModel.state.items) { $comment in
            CommentView(comment: $comment, onClick: {
                
            }, onOptionClicked: {
                viewModel.comment = comment
                viewModel.state.showOptionSheet = true
            }, onReplyClicked: {
                
            }, onLikeClicked: {
                let likeCommentBody = LikeCommentBody(comment_id: comment.id, email: UserSettings.email ?? "")
                viewModel.likeComment(likeCommentBody: likeCommentBody)
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
    
    
    func scrollToBottom(proxy: ScrollViewProxy){
        DispatchQueue.main.async {
                  proxy.scrollTo("bottom", anchor: .bottom)
              }
    }
    
    
    func deleteComment(){
        showErrorMessage(message: "Are you sure you want to delete this comment" , actionTitle: "Delete", showCancel: true, action: {
            
            if let comment = viewModel.comment{
                
                let deleteCommentBody = DeleteCommentBody(comment_id: comment.id, reason: "", is_admin: false)
                
                viewModel.deleteComment(deleteCommentBody: deleteCommentBody, postId: postId, buyerEmail: UserSettings.email ?? "")
                
               
                
            }
            
        })
    }
    
}
    
    
    
    #Preview {
        CommentScreenPreviewWrapper(post: Post.preview, postId: "3")
    }
    
    struct CommentScreenPreviewWrapper: View{
        
        var post: Post
        let postId: String
        
        init(post: Post, postId: String) {
            self.post = post
            self.postId = postId
        }
        
        var body: some View {
            CommentScreen(post: post, postId: postId, showKeyPad: true)
        }
        
        
    }

