//
//  GoToReview.swift
//  Q and A
//
//  Created by GIGL-PC on 22/06/2026.
//

import Foundation

struct GoToReview{
    
    let id: String = UUID().uuidString
    let questionIndex: Int
    let isCorrect: Bool
    var isSeleceted: Bool = false
    
}
