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
    
}
