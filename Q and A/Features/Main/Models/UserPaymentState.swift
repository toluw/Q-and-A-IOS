//
//  UserPaymentState.swift
//  Q and A
//
//  Created by GIGL-PC on 21/08/2026.
//

import Foundation

struct UserPaymentState{
    

 var items: [Payment] = []
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
    var showLoader: Bool = false

    var isEmpty: Bool {
        items.isEmpty && !isLoading && errorMessage == nil
    }
    
}
