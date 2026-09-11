//
//  CommentViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 04/08/2026.
//

import Foundation

@MainActor
class CommentViewModel: ObservableObject{
    
    @Published var state = CommentState()
    
    @Published var postState: Post? = nil
    
    var comment: Comment? = nil
    
    private let service: CommunityServiceProtocol
    
    
    init(service: CommunityServiceProtocol = CommunityService()) {
        self.service = service
    }
    
    
    
    
    
    
    
    /// Call once, e.g. from `.task` on first appearance.
    func loadInitial(postId: String, buyerEmail: String) async {
        guard state.items.isEmpty else { return }
        await fetch(postId: postId, buyerEmail: buyerEmail, page: 1, isRefresh: false)
    }
    
    
    /// Pull-to-refresh, and also used to retry a failed initial load.
    func refresh(postId: String, buyerEmail: String) async {
        await fetch(postId: postId, buyerEmail: buyerEmail,page: 1, isRefresh: true)
    }

    /// Triggered automatically as the user scrolls near the end of the list.
    func loadMoreIfNeeded(postId: String, buyerEmail: String, currentItem: Comment) async {
        guard let last = state.items.last, last.id == currentItem.id else { return }
        await loadMore(postId: postId, buyerEmail: buyerEmail)
    }

    /// Also callable directly from a "Retry" button in the footer.
    func loadMore(postId: String, buyerEmail: String) async {
        guard !state.isLoading, !state.isLoadingMore else { return }
        guard state.hasMorePages else { return }
        await fetch(postId: postId, buyerEmail: buyerEmail, page: state.currentPage + 1, isRefresh: false)
    }
    
    
    func updateComment(updateCommentBody: UpdateCommentBody, postId: String, buyerEmail: String){
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.updateComment(updateCommentBody: updateCommentBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Your post was successfully submitted", type: .success)
                await refresh(postId: postId, buyerEmail: buyerEmail)
            }catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.updateComment(updateCommentBody: updateCommentBody, postId: postId, buyerEmail: buyerEmail)
                })
            }
        }
    }
    
    func likePost(postBody: PostBody){
    
        Task{
            do{
                let response =   try await service.likePost(postBody: postBody)
            } catch {
                
            }
    }
}
    
    
    func deleteComment(deleteCommentBody: DeleteCommentBody, postId: String, buyerEmail: String){
        
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.deleteComment(deleteCommentBody: deleteCommentBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Post Deleted Successfully", type: .success)
                await refresh(postId: postId, buyerEmail: buyerEmail)
                
            } catch{
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.deleteComment(deleteCommentBody: deleteCommentBody, postId: postId, buyerEmail: buyerEmail)
                })
                
            }
            
        }
        
    }
    
    func likeComment(likeCommentBody: LikeCommentBody){
        
        Task{
            
            do{
               
                let response = try await service.likeComment(likeCommentBody: likeCommentBody)
                
            }catch{
                
            }
            
        }
    }
    
    func getPostById(postId: String, email: String){
        Task{
            
            do{
               
                postState = try await service.getPostById(id: postId, buyerEmail: email).data
                
            }catch{
                
            }
            
        }
    }
    
    
    func createComment(createCommentBody: CreateCommentBody, postId: String, buyerEmail: String){
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.createComment(createCommentBody: createCommentBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Your post was successfully submitted", type: .success)
                NotificationManager.shared.presentPrimerIfNeeded(for: .newComment)
                await refresh(postId: postId, buyerEmail: buyerEmail)
            }catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.createComment(createCommentBody: createCommentBody, postId: postId, buyerEmail: buyerEmail)
                })
            }
        }
    }
    
    
    
    private func fetch(postId: String, buyerEmail: String, page: Int, isRefresh: Bool) async {
        let isLoadMore = page > 1

        if isLoadMore {
            state.isLoadingMore = true
            state.loadMoreErrorMessage = nil
        } else {
            state.isLoading = true
            state.errorMessage = nil
        }

        do {
            let response = try await service.getComment(postId: postId, buyerEmail: buyerEmail, page: String(page))

            state.currentPage = response.data.page
            state.totalPages = response.data.total_pages

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
