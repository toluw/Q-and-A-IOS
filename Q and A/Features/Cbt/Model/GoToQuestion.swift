//
//  GoToQuestion.swift
//  Q and A
//
//  Created by GIGL-PC on 04/06/2026.
//

import Foundation

struct GoToQuestion: Identifiable{
    
    let id: String = UUID().uuidString
    let questionIndex: Int
    let hasAttempted: Bool
    var isSeleceted: Bool = false
    
    
    
    
}
