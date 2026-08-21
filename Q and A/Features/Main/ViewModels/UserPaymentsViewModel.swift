//
//  UserPaymentsViewModel.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation


@MainActor
class UserPaymentsViewModel: ObservableObject {
    
    @Published var state = UserPaymentState()
    
   
    

    private let service: MainServiceProtocol
    
    
      
      init(service:  MainServiceProtocol = MainService()) {
          self.service = service
      }
    
    
    
    
    /// Call once, e.g. from `.task` on first appearance.
    func loadInitial() async {
        guard state.items.isEmpty else { return }
        await fetch(page: 1)
    }
    
    
    /// Pull-to-refresh, and also used to retry a failed initial load.
    func refresh() async {
        await fetch(page: 1)
    }

    /// Triggered automatically as the user scrolls near the end of the list.
    func loadMoreIfNeeded(currentItem: Payment) async {
        guard let last = state.items.last, last.id == currentItem.id else { return }
        await loadMore()
    }

    /// Also callable directly from a "Retry" button in the footer.
    func loadMore() async {
        guard !state.isLoading, !state.isLoadingMore else { return }
        guard state.hasMorePages else { return }
        await fetch(page: state.currentPage + 1)
    }
    
    
    
    
    
    
    private func fetch(page: Int) async{
        
        let isLoadMore = page > 1

        if isLoadMore {
            state.isLoadingMore = true
            state.loadMoreErrorMessage = nil
        } else {
            state.isLoading = true
            state.errorMessage = nil
        }
        
        do {
           
            
            let response = try await service.getUserPayments(email: UserSettings.email ?? "", page: String(page))
            
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
