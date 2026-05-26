//
//  CatState.swift
//  Q and A
//
//  Created by GIGL-PC on 25/05/2026.
//

import Foundation

struct CatState{
    var isLoading: Bool = false
    var initItems: [CatExams] = []
    var errorMessage: String? = nil
    var items: [CatExams] = []
    var examSelectList: [CatExamSelect] = []
    var maxExamSelectedMessage: String = ""
    var selectExam: SelectExam? = nil
    var selectQuestion: SelectQuestion? = nil
    var searchText: String = ""
    var emptyStateText: String = "Oops! There is no content yet. Please check back later"
    var showBlockedLoader: Bool = false
    var multipleExamData: [MultipleExamsResponse.MultipleExamData] = []
    var showPaymentSheet: Bool = false
    var examWithTitle: ExamWithTitle? = nil
}
