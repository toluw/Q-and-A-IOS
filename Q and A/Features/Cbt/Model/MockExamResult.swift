//
//  MockExamResult.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import Foundation

struct MockExamResult: Codable, Equatable, Hashable{
    let examResultList: [ExamResult]
    let title: String
    
    static let preview = MockExamResult(examResultList: [ExamResult.preview, ExamResult.preview, ExamResult.preview], title: <#T##String#>)
}
