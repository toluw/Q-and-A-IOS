//
//  BundleState.swift
//  Q and A
//
//  Created by GIGL-PC on 16/10/2026.
//

import Foundation

struct BundleState{
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var canContinue: Bool = false
    var items: [BundleWithSelection] = []
    var bundlePriceTxt: String = 0.formatted(.currency(code: "NGN").precision(.fractionLength(0)))
    var originalPriceTxt: String = 0.formatted(.currency(code: "NGN").precision(.fractionLength(0)))
    var isSelectAll: Bool = false
    var isDataEmpty: Bool = false
    var title: String = ""
    var description: String = ""
    var selectSubjectTxt: String = ""
    var subjectSelectedTxt: String = ""

}
