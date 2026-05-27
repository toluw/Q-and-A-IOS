//
//  ExamDescriptionView.swift
//  Q and A
//
//  Created by GIGL-PC on 27/05/2026.
//

import SwiftUI

struct ExamDescriptionView: View {
    
    let selectedExam: ExamSelect
    let selectedColor: String
    let onStartExam: () -> Void
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                
                ZStack{
                    LoadImageView(url: selectedExam.image, width: 43 , height: 43)
                }.frame(width: 64, height: 64)
                    .background(Color.white).opacity(0.1)
                
                VStack{
                      
                    Text(selectedExam.category)
                        .font(AppFont.semi_bold(18))
                        .foregroundColor(Color.white)
                    
                    Text(selectedExam.item)
                        .font(AppFont.medium(18))
                        .foregroundColor(Color.white)
                    
                }.padding(.leading, 15)
                
                Spacer()
                 
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 65)
                .padding(.trailing, 65)
                .padding(.bottom, 30)
                .padding(.top, 80)
            
            
            VStack{
                
                ScrollView{
                    
                }.frame(maxWidth: .infinity)
                
                Spacer()
                
                PrimaryButton(buttonText: "Start Exam", action: onStartExam)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.top, 16)
                    .padding(.bottom, 25)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white.clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 20,
                        topTrailingRadius: 20
                    )
                ))
                .ignoresSafeArea(edges: .bottom)
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(selectedColor))
            .ignoresSafeArea(edges: .top)
            
    }
}

#Preview {
    
    let exam = Exam(cbtId: "2", subcatId: "3", numQuestions: 50, price: 50, title: "Analog Computing", instruction: "Welcome to Analog computing", description: "Welcome Home", duration: 20, isActive: true, createdAt: "", sellerEmail: "", hasSample: false, examId: "2", isProvisioned: true, numViews: 10, isMaxAttempt: true, startTime: "", isCompulsory: "1")
    
    let selectExam = ExamSelect(item: "English", exam: exam, numQuestions: 2, shouldShuffle: true, category: "WAEC", disableReview: true
)
    
    ExamDescriptionView(selectedExam: selectExam, selectedColor: "cb0", onStartExam: {})
}
