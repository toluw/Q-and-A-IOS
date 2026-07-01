//
//  AnswerData.swift
//  Q and A
//
//  Created by GIGL-PC on 01/07/2026.
//

import Foundation

struct AnswerData: Identifiable{
    let id = UUID()
    let answerChar: String
    let answerText: String
    let image: String?
    
}
