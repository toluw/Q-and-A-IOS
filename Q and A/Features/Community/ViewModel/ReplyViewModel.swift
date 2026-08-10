//
//  ReplyViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 10/08/2026.
//

import Foundation


@MainActor
class ReplyViewModel: ObservableObject{
    
    
    @Published var state = ReplyState()
    
    @Published var commentState: Comment? = nil
    
    var reply: Reply? = nil
    
    private let service: CommunityServiceProtocol
    
    
    init(service: CommunityServiceProtocol = CommunityService()) {
        self.service = service
    }
    
    
    
    
    
    
    
    /// Call once, e.g. from `.task` on first appearance.
    func loadInitial(commentId: String, buyerEmail: String) async {
        guard state.items.isEmpty else { return }
        await fetch(commentId: commentId, buyerEmail: buyerEmail, page: 1, isRefresh: false)
    }
    
    
    /// Pull-to-refresh, and also used to retry a failed initial load.
    func refresh(commentId: String, buyerEmail: String) async {
        await fetch(commentId: commentId, buyerEmail: buyerEmail,page: 1, isRefresh: true)
    }

    /// Triggered automatically as the user scrolls near the end of the list.
    func loadMoreIfNeeded(commentId: String, buyerEmail: String, currentItem: Reply) async {
        guard let last = state.items.last, last.id == currentItem.id else { return }
        await loadMore(commentId: commentId, buyerEmail: buyerEmail)
    }

    /// Also callable directly from a "Retry" button in the footer.
    func loadMore(commentId: String, buyerEmail: String) async {
        guard !state.isLoading, !state.isLoadingMore else { return }
        guard state.hasMorePages else { return }
        await fetch(commentId: commentId, buyerEmail: buyerEmail, page: state.currentPage + 1, isRefresh: false)
    }
    
    
    func updateReply(updateReplyBody: UpdateReplyBody, commentId: String, buyerEmail: String){
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.updateReply(updateReplyBody: updateReplyBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Your post was successfully submitted", type: .success)
                await refresh(commentId: commentId, buyerEmail: buyerEmail)
            }catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.updateReply(updateReplyBody: updateReplyBody, commentId: commentId, buyerEmail: buyerEmail)
                })
            }
        }
    }
    
    func likeComment(likeCmmentBody: LikeCommentBody){
    
        Task{
            do{
                let response =   try await service.likeComment(likeCommentBody: likeCmmentBody)
            } catch {
                
            }
    }
}
    
    
    func deleteReply(deleteReplyBody: DeleteReplyBody, commentId: String, buyerEmail: String){
        
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.deleteReply(deleteReplyBody: deleteReplyBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Post Deleted Successfully", type: .success)
                await refresh(commentId: commentId, buyerEmail: buyerEmail)
                
            } catch{
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.deleteReply(deleteReplyBody: deleteReplyBody, commentId: commentId, buyerEmail: buyerEmail)
                })
                
            }
            
        }
        
    }
    
    func likeReply(likeReplyBody: LikeReplyBody){
        
        Task{
            
            do{
               
                let response = try await service.likeReply(likeReplyBody: likeReplyBody)
                
            }catch{
                
            }
            
        }
    }
    
    func getCommentById(commentId: String, email: String){
        Task{
            
            do{
               
                commentState = try await service.getCommentById(id: commentId, buyerEmail: email).data
               
                
            }catch{
                
            }
            
        }
    }
    
    
    func createReply(createReplyBody: CreateReplyBody, commentId: String, buyerEmail: String){
        state.showBlockedLoader = true
        
        Task{
            
            do{
                let response = try await service.createReply(createReplyBody: createReplyBody)
                state.showBlockedLoader = false
                state.responseMessage = ToastData(message: "Your post was successfully submitted", type: .success)
                await refresh(commentId: commentId, buyerEmail: buyerEmail)
            }catch {
                state.showBlockedLoader = false
                showErrorMessage(message: error.localizedDescription, actionTitle: "Retry", action: {
                    self.createReply(createReplyBody: createReplyBody, commentId: commentId, buyerEmail: buyerEmail)
                })
            }
        }
    }
    
    
    
    private func fetch(commentId: String, buyerEmail: String, page: Int, isRefresh: Bool) async {
        let isLoadMore = page > 1

        if isLoadMore {
            state.isLoadingMore = true
            state.loadMoreErrorMessage = nil
        } else {
            state.isLoading = true
            state.errorMessage = nil
        }

        do {
            let response = try await service.getReply(commentId: commentId, buyerEmail: buyerEmail, page: String(page))

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
