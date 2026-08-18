//
//  CbtHistoryState.swift
//  Q and A
//
//  Created by GIGL-PC on 18/08/2026.
//

import Foundation

struct CbtHistoryState{
    

 var items: [CbtHistory] = []
    var currentPage: Int = 0
    var totalPages: Int = 1
    // Initial load / pull-to-refresh
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var hasMorePages: Bool {
        currentPage < totalPages
    }
    
    var isLoadingMore: Bool = false
    var loadMoreErrorMessage: String? = nil

    var isEmpty: Bool {
        items.isEmpty && !isLoading && errorMessage == nil
    }
    
}
