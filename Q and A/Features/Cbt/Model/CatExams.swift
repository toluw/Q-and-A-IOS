//
//  CatExams.swift
//  Q and A
//
//  Created by GIGL-PC on 25/05/2026.
//

import Foundation

struct CatExams: Equatable {
    let exam: Exam
    var isChecked: Bool = false
    var questionText: String = ""
    var numViews: String = ""
    var isShuffle: Bool = false
    var defaultQuestions: Int = 1
}
