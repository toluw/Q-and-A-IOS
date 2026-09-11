//
//  CbtPostViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation


@MainActor
class CbtPostViewModel: ObservableObject{
    
    
    @Published var state = PostState()
    
    
    
    var post: Post? = nil
    
    private let service: CommunityServiceProtocol
    
    
      
      init(service: CommunityServiceProtocol = CommunityService()) {
          self.service = service
      }
    
    
    
    
    
        func likePost(postBody: PostBody){
        
            Task{
                do{
                    let response =   try await service.likePost(postBody: postBody)
                } catch {
                    
                }
        }
    }
    
    
    
    func createPost(createPostBody: CreatePostBody, examId: String, questionId: String, buyerEmail: String){
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.createPost(createPostBody: createPostBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Your post was successfully submitted", type: .success)
                NotificationManager.shared.presentPrimerIfNeeded(for: .newPost)
                await refresh(examId: examId, questionId: questionId, buyerEmail: buyerEmail)
            }catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.createPost(createPostBody: createPostBody, examId: examId, questionId: questionId, buyerEmail: buyerEmail)
                })
            }
        }
    }
    
    
    func updatePost(updatePostBody: UpdatePostBody, examId: String, questionId: String, buyerEmail: String){
        
        state.showBlockedLoader = true
        
        Task{
            
            do{
               
                let response = try await service.updatePost(updatePostBody: updatePostBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Your post was successfully edited", type: .success)
                await refresh(examId: examId, questionId: questionId, buyerEmail: buyerEmail)
                
            }catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.updatePost(updatePostBody: updatePostBody, examId: examId, questionId: questionId, buyerEmail: buyerEmail)
                })
            }
            
        }
        
    }
    
    
    
    
    func deletePost(deletePostBody: DeletePostBody, examId: String, questionId: String, buyerEmail: String){
        
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.deletePost(deletePostBody: deletePostBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Post Deleted Successfully", type: .success)
                await refresh(examId: examId, questionId: questionId, buyerEmail: buyerEmail)
                
            } catch{
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.deletePost(deletePostBody: deletePostBody, examId: examId, questionId: questionId, buyerEmail: buyerEmail)
                })
                
            }
            
        }
        
    }
    
    
    /// Call once, e.g. from `.task` on first appearance.
    func loadInitial(examId: String, questionId: String, buyerEmail: String) async {
        guard state.items.isEmpty else { return }
        await fetch(examId: examId, questionId: questionId, buyerEmail: buyerEmail, page: 1, isRefresh: false)
    }
    
    
    /// Pull-to-refresh, and also used to retry a failed initial load.
    func refresh(examId: String, questionId: String, buyerEmail: String) async {
        await fetch(examId: examId, questionId: questionId, buyerEmail: buyerEmail,page: 1, isRefresh: true)
    }

    /// Triggered automatically as the user scrolls near the end of the list.
    func loadMoreIfNeeded(examId: String, questionId: String, buyerEmail: String, currentItem: Post) async {
        guard let last = state.items.last, last.id == currentItem.id else { return }
        await loadMore(examId: examId, questionId: questionId, buyerEmail: buyerEmail)
    }

    /// Also callable directly from a "Retry" button in the footer.
    func loadMore(examId: String, questionId: String, buyerEmail: String) async {
        guard !state.isLoading, !state.isLoadingMore else { return }
        guard state.hasMorePages else { return }
        await fetch(examId: examId, questionId: questionId, buyerEmail: buyerEmail, page: state.currentPage + 1, isRefresh: false)
    }
    
    private func fetch(examId: String, questionId: String, buyerEmail: String, page: Int, isRefresh: Bool) async {
        let isLoadMore = page > 1

        if isLoadMore {
            state.isLoadingMore = true
            state.loadMoreErrorMessage = nil
        } else {
            state.isLoading = true
            state.errorMessage = nil
        }

        do {
            let response = try await service.getPost(examId: examId, questionId: questionId, buyerEmail: buyerEmail, page: String(page))

            state.currentPage = response.data.page
            state.totalPages = response.data.totalPages

            if isLoadMore {
                state.items.append(contentsOf: response.data.items)
            } else {
                state.items = response.data.items
            }

            state.isLoading = false
            state.isLoadingMore = false

        } catch {
            if isLoadMore {
                state.isLoadingMore = false
                state.loadMoreErrorMessage = error.localizedDescription
            } else {
                state.isLoading = false
                state.errorMessage = error.localizedDescription
            }
        }
    }
    
    
}
