//
//  SubCatExamSelect.swift
//  Q and A
//
//  Created by GIGL-PC on 22/04/2026.
//

import Foundation

struct SubCatExamSelect: Equatable{
    var cbtId: String
    var item: String
    var subcatId: String
    var exam: Exam
    var numQuestions: Int
    var shouldShuffle: Bool
    var disableReview: Bool
}
