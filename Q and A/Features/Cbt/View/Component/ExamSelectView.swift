//
//  ExamSelectView.swift
//  Q and A
//
//  Created by GIGL-PC on 28/04/2026.
//

import SwiftUI

struct ExamSelectView: View {
    
    
    let exam: Exam
    let onClick: () -> Void
    
    var body: some View {
        Button(
            action: {
              onClick()
            }
        ){
            ZStack{
                HStack{
                    Text(exam.title)
                        .font(AppFont.regular(18))
                    
                    Spacer()
                    
                    if(!exam.isProvisioned){
                        HStack{
                            
                            Text(exam.price, format: .currency(code: "NGN"))
                                .font(AppFont.medium(18))
                                .foregroundColor(Color("Gold"))
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                            
                            Image("lock")
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 16)
                .padding(.bottom, 16)
                .padding(.leading, 24)
                .padding(.trailing, 24)
            }.frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
    }
}

#Preview {
    
    let exam = Exam(cbtId: "", subcatId: "", numQuestions: 20, price: 500, title: "Economics", instruction: "", description: "", duration: 20, isActive: true, createdAt: "", sellerEmail: "", hasSample: true, examId: "1", isProvisioned: true, numViews: 3, isMaxAttempt: true, startTime: "", isCompulsory: "")
    ExamSelectView(exam: exam, onClick: {})
}
