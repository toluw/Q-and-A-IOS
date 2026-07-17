//
//  ExamDescriptionView.swift
//  Q and A
//
//  Created by GIGL-PC on 27/05/2026.
//

import SwiftUI

struct ExamDescriptionView: View {
    
    let selectedExam: ExamSelect
    @Binding var selectedColor: String
    let onStartExam: () -> Void
    let onBackClicked: () -> Void
    
    var body: some View {
        
        ZStack{
            Color(selectedColor)
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .leading){
                
                
            
                HStack(alignment: .top){
                    
                    Button {
                       onBackClicked()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }.padding(.leading, 30)
                    
                    HStack{
                        
                        
                        (Color.white).opacity(0.1).frame(width: 64, height: 64).cornerRadius(14)
                            .overlay(content: {
                                LoadCircularImageView(url: selectedExam.image, width: 43 , height: 43)
                            })
                            
                        
                        
                        
                        VStack(alignment: .leading){
                              
                            Text(selectedExam.category)
                                .font(AppFont.semi_bold(18))
                                .foregroundColor(Color.white)
                            
                            Text(selectedExam.item)
                                .font(AppFont.regular(18))
                                .foregroundColor(Color.white)
                            
                        }.padding(.leading, 16)
                        
                        Spacer()
                         
                        
                    }.frame(maxWidth: .infinity)
                        .padding(.leading, 40)
                        .padding(.trailing, 65)
                        .padding(.bottom, 30)
                        .padding(.top, 5)
                        
                       
                    
                }.frame(maxWidth: .infinity)
                    .padding(.top, 5)
                
                
                
               
                
                
                VStack{
                    
                    ScrollView{
                        
                        CbtDescriptionView(duration: selectedExam.getExamTime().toHourString(), numQuestions: "\(selectedExam.numQuestions) questions", description: selectedExam.exam.description, instruction: selectedExam.exam.instruction)
                        
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
               
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
            
    }
}

#Preview {
  
    ExamDescriptionViewPreveiwWrapper()
    
}


struct ExamDescriptionViewPreveiwWrapper: View {
    
    @State private var selectedColor: String
    let selectExam: ExamSelect
    
    
    init(){
        
        let ex = Exam(cbtId: "2", subcatId: "4", numQuestions: 4, price: 500, title: "Map", instruction: "Wao", description: "Meet them", duration: 9, isActive: true, createdAt: "", sellerEmail: "qapp", hasSample: true, examId: "e", isProvisioned: true, numViews: 4, isMaxAttempt: true, startTime: "trie", isCompulsory: "1")
        
        selectExam = ExamSelect(item: "English", exam: ex, numQuestions: 2, shouldShuffle: true, category: "WAEC", disableReview: true
    )
        
        selectedColor = "cb1"
                                                                                                 
                                                                                                                                                                                                                                                                                                                                                            }
    
    
    var body: some View {
        
        
        ExamDescriptionView(selectedExam: selectExam, selectedColor: $selectedColor, onStartExam: {}, onBackClicked: {})
    }
    
}
