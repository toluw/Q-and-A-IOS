//
//  SubCatExamItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 22/04/2026.
//

import SwiftUI

struct SubCatExamItemView: View {
    
    
    @Binding var subCatExam: SubCatExams
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                
                
            }
            
        }.frame(maxWidth: .infinity)
        
    }
}




#Preview {
    SubCatExamItemViewPreveiwWrapper()
}


struct SubCatExamItemViewPreveiwWrapper: View {
    
    @State private var subCatExam: SubCatExams
    
    
    init(){
        
        let ex = Exam(cbtId: "2", subcatId: "4", numQuestions: 4, price: 500, title: "Map", instruction: "Wao", description: "Meet them", duration: 9, isActive: true, createdAt: "", sellerEmail: "qapp", hasSample: true, examId: "e", isProvisioned: true, numViews: 4, isMaxAttempt: true, startTime: "trie", isCompulsory: "1")
        
        var examList: [Exam] { [ex, ex, ex, ex] }
        
        var subCategoryData = SubCategoryData(
            cbtId: "",
            item: "Bag",
            createdAt: "",
            isActive: true,
            subcatId: "",
            exams: examList
        )
        
        _subCatExam = State(initialValue: SubCatExams(data: subCategoryData))
        
    }
    
    
    var body: some View {
        SubCatExamItemView(subCatExam: $subCatExam)
    }
    
}
