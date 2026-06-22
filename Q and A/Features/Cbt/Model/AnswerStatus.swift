//
//  AnswerStatus.swift
//  Q and A
//
//  Created by GIGL-PC on 20/06/2026.
//

import Foundation


struct AnswerStatus: Identifiable{
    
    
    let id = UUID()
    let answer: String
        let content: String
        let image: String?
    let isCorrect: Bool
    
    
}
