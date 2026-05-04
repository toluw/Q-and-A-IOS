//
//  MultipleExam.swift
//  Q and A
//
//  Created by GIGL-PC on 04/05/2026.
//

import Foundation

struct MultipleExam: Codable, Equatable{
    let examId: String
    let item: String
    let liveExamList: [LiveExam]
    
}
