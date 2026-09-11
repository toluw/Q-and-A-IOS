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
        ZStack{
            
            
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
                
                SocialPostInputView(text: $viewModel.state.content, label: "Join the conversation..", quote: nil, requestFocus: $viewModel.state.requestFocus, onSubmit: {text, base64Image in
                   
                    
                    if(viewModel.state.isEdit){
                        
                        let updatePostBody = UpdatePostBody(post_id: viewModel.post?.id ?? "", content: text, image: base64Image, title: "")
                        
                        viewModel.updatePost(updatePostBody: updatePostBody, examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
                        
                    }else{
                        
                        let createPostBody = CreatePostBody(exam_id: examId, question_id: liveExam?.questionId ?? "", email: UserSettings.email ?? "", content: text, image: base64Image)
                        
                        viewModel.createPost(createPostBody: createPostBody, examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
                        
                    }
                    
                    viewModel.state.content = ""
                    viewModel.state.isEdit = false
                    
                    
                    
                }, onCloseQuote: {})
            }
            .frame(maxWidth: .infinity)
            .background(Color("post_bg"))
            .padding(.top, 2)
            
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
                            viewModel.state.content = viewModel.post?.content ?? ""
                            
                        }else if(option == DELETE){
                            
                            deletePost()
                        }
                        
                        
                    })
                    .transition(.scale)
                    
                }

                
            }
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .refreshable {
                await viewModel.refresh(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
            }
            .task {
                await viewModel.loadInitial(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
            }
            .toastBanner(toast: $viewModel.state.responseMessage)
            .toolbar {
                
                // Title
                ToolbarItem(placement: .principal) {
                    Text("Discussion").font(AppFont.regular(18))
                }
                
                
            }
            /*
            .sheet(isPresented: $viewModel.state.showOptionSheet){
                OptionBottomSheet(items: [EDIT,DELETE], onItemClicked: {option in
                    viewModel.state.showOptionSheet = false
                    if(option == EDIT){
                        
                    }else if(option == DELETE){
                        
                        deletePost()
                    }
                    
                    
                }).presentationDetents([.medium])
            }
             */
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
        ForEach($viewModel.state.items) { $post in
            CbtPostView(post: $post, onClick: {
                moveToComments(post: post, showKeypad: true)
            }, onOptionClicked: {
                viewModel.post = post
                viewModel.state.showOptionSheet = true
            }, onCommentClicked: {
                moveToComments(post: post, showKeypad: true)
            }, onLikeClicked: {
                
                let postBody = PostBody(post_id: post.id, email: UserSettings.email ?? "")
                
                viewModel.likePost(postBody: postBody)
                
            })
                .task {
                    await viewModel.loadMoreIfNeeded(examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "", currentItem: post)
                }
        }

        paginationFooter
    }
    
    private func moveToComments(post: Post, showKeypad: Bool){
        navVm.navigate(route: .commentScreen(post: post, postId: post.id, showKeyPad: showKeypad))
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
    
    private func deletePost(){
        showErrorMessage(message: "Are you sure you want to delete this post" , actionTitle: "Delete", showCancel: true, action: {
            
            if let post = viewModel.post{
                
                let deletePostBody = DeletePostBody(post_id: post.id)
                viewModel.deletePost(deletePostBody: deletePostBody, examId: examId, questionId: liveExam?.questionId ?? "", buyerEmail: UserSettings.email ?? "")
                
            }
            
        })
    }
}

#Preview {
    CbtPostScreen(navVm: MainNavViewModel(), examId: "2", liveExam: LiveExam.preview)
}
