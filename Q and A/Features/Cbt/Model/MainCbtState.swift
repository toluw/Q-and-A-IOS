//
//  MainCbtState.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import Foundation

struct MainCbtState{
    
    var isLoading: Bool = false
    var items: [BaseCat] = []
    var errorMessage: String? = nil
    var showBlockedLoader: Bool = false
    var parentCatData: [DataModel]? = nil
    
    
}
