//
//  SubCatState.swift
//  Q and A
//
//  Created by GIGL-PC on 22/04/2026.
//

import Foundation

struct SubCatState{
    
    var isLoading: Bool = false
    var initItems: [SubCatExams] = []
    var errorMessage: String? = nil
    var items: [SubCatExams] = []
    var examSelectList: [SubCatExamSelect] = []
    var maxExamSelectedMessage: String = ""
    var selectExam: SelectExam? = nil
    var selectQuestion: SelectQuestion? = nil
    var searchText: String = ""
    var emptyStateText: String = "Oops! There is no content yet. Please check back later"
    var showBlockedLoader: Bool = false
    var multipleExamData: [MultipleExamsResponse.MultipleExamData] = []
    
    
}
