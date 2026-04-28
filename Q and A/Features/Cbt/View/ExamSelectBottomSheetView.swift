//
//  ExamSelectBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 28/04/2026.
//

import SwiftUI

struct ExamSelectBottomSheetView: View {
    
    
    let selectExam: SelectExam
    
    @State var initExams: [Exam] = []
    @State var exams: [Exam] = []
    @State var searchText: String = ""
    
    
    var body: some View {
        ZStack{
            
            if(exams.isEmpty){
                
                EmptyStateView(title: "No content yet, please check back letter")
                
            }else{
                
                VStack(){
                    
                    Text(selectExam.title)
                        .font(AppFont.regular(16))
                        .padding(.top, 30)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    TextField("Search..", text: $searchText)
                        .padding(.leading,20)
                        .padding(.trailing,20)
                        .padding(.top, 30)
                        .textFieldStyle(.roundedBorder)
                    
                    
                    ScrollView{
                        
                        LazyVStack{
                            
                            ForEach(exams){ data in
                                ExamSelectView(exam: data, onClick: {})
                            }
                            
                        }
                        
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear{
                initExams = selectExam.exams
                exams = selectExam.exams
            }
    }
}

#Preview {
    
   let exam = Exam(cbtId: "", subcatId: "", numQuestions: 20, price: 500, title: "Economics", instruction: "", description: "", duration: 20, isActive: true, createdAt: "", sellerEmail: "", hasSample: true, examId: "1", isProvisioned: true, numViews: 3, isMaxAttempt: true, startTime: "", isCompulsory: "")
    
    let exams = [exam, exam, exam]
    
    let selectExam = SelectExam(exams: exams, position: 2, title: "English")
    
    ExamSelectBottomSheetView(selectExam: selectExam)
}
