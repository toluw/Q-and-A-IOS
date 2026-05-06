//
//  ExamPayView.swift
//  Q and A
//
//  Created by GIGL-PC on 06/05/2026.
//

import SwiftUI

struct ExamPayView: View {
    
    @Binding var examPay: ExamPay
    
    var body: some View {
        Button(action: {
            
        }){
           
            ZStack{
                
                
             
                HStack{
                   
                    HStack{
                        
                        ZStack{
                            
                            if(examPay.isSelected){
                                Image("prem_check")
                            }else{
                                Image("prem_uncheck")
                            }
                            
                        }
                        
                        Text(examPay.exam.title)
                            .font(AppFont.regular(18))
                            .foregroundColor(Color("GreyText"))
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                        
                        Spacer()
                        
                        HStack{
                            
                            Text(examPay.exam.price, format: .currency(code: "NGN"))
                                .font(AppFont.medium(18))
                                .foregroundColor(Color("PayColor"))
                                .padding(.trailing, 10)
                            
                            
                            Image("padlock")
                              
                            
                        }
                        
                    }
                    
                }.padding(.top, 15)
                    .padding(.bottom, 15)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            
            }.frame(maxWidth: .infinity)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
    }
}

#Preview {
    ExamPayPreviewWrapper()
}


struct ExamPayPreviewWrapper: View {
    
    @State var examPay: ExamPay
    var exam: Exam
    
    init() {
        
        exam = Exam(cbtId: "1", subcatId: "2", numQuestions: 4, price: 300, title: "Geography", instruction: "Do your best", description: "Welcome abroad", duration: 5, isActive: true, createdAt: "", sellerEmail: "", hasSample: true, examId: "2", isProvisioned: true, numViews: 3, isMaxAttempt: false, startTime: "", isCompulsory: "1")
        
        self.examPay = ExamPay(exam: exam, isSelected: true)
    }
    
    var body: some View {
       ExamPayView(examPay: $examPay)
    }
}
