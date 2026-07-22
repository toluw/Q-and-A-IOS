//
//  PostState.swift
//  Q and A
//
//  Created by GIGL-PC on 17/07/2026.
//

import Foundation

struct PostState{
    
    var showOptionSheet = false
    
    var showBlockedLoader = false
    
    var items: [Post] = []

    var currentPage: Int = 0
    var totalPages: Int = 1

    // Initial load / pull-to-refresh
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    var isEdit: Bool = false
    var content:String = ""

    // Load-more (next page) — kept separate so a load-more failure
    // never blanks out the list the user already sees.
    var isLoadingMore: Bool = false
    var loadMoreErrorMessage: String? = nil

    var hasMorePages: Bool {
        currentPage < totalPages
    }

    var isEmpty: Bool {
        items.isEmpty && !isLoading && errorMessage == nil
    }
    
}
