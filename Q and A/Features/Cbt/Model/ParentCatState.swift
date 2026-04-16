//
//  ParentCatState.swift
//  Q and A
//
//  Created by GIGL-PC on 16/04/2026.
//

import Foundation

struct ParentCatState{
    
   
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var parentCatData: [DataModel] = [DataModel(
        cbcId: "",
        isCat: true,
        item: "Lobby",
        isActive: true,
        isMock: "2",
        level: "1",
        catData: nil,
        createdAt: ""
    )]
    var emptyStateText: String = "Oops! There is no content yet. Please check back later"
    
    
    
    
}
