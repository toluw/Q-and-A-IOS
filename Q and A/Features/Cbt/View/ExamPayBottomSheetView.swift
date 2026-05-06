//
//  ExamPayBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 06/05/2026.
//

import SwiftUI

struct ExamPayBottomSheetView: View {
    
    let examWithTitle: ExamWithTitle
    let premiumExams: [Exam]
    
    @State var examPaymentList: [ExamPay] = []
    @State var totalPrice: Int = 0
    @State var isSelectAll: Bool = false
    
    let onClose: () -> Void
    
    let onPaymentClicked: ([ExamPay]) -> Void
    
    
    let onAddToCart: ([ExamPay]) -> Void
    
    
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Button(action: {
              onClose()
            }){
               Image("app_close")
                    .padding(.leading, 20)
            }
            
            HStack{
                
                Spacer()
                
                Text(examWithTitle.title)
                    .font(AppFont.regular(16))
                
                
                Spacer()
            }
            
            
            Button(action: {
                
            }){
              
                HStack{
                    
                    ZStack{
                        
                        if(isSelectAll){
                            Image("prem_check")
                        }else{
                            Image("prem_uncheck")
                        }
                        
                    }
                    
                    Text("Select all")
                        .font(AppFont.regular(18))
                        .foregroundColor(Color("GreyText"))
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                  
                    
                    
                }.padding(.bottom, 15)
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    .contentShape(Rectangle())
                
            }.buttonStyle(.plain)
            
        
            
            
            
            ScrollView{
               
                LazyVStack{
                    
                    ForEach($examPaymentList){ data in
                        ExamPayView(examPay: data)
                    }
                    
                    
                }
                
                
            }
            
            Spacer()
            
            
            VStack{
                
                ZStack{
                    if(totalPrice > 0){
                        PaymentButton(buttonText: "Pay \(totalPrice.formatted(.currency(code: "NGN")))"){
                          onPaymentClicked(getSelectedExamPay())
                        }
                    }else{
                       
                        DisabledButton(buttonText: "Pay")
                        
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                
                ZStack{
                    if(totalPrice > 0){
                        SecondaryButton(buttonText: "Add to Cart", action: {
                           onAddToCart(getSelectedExamPay())
                        })
                    }else{
                       
                        DisabledButton(buttonText: "Add to Cart")
                        
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
                
            }.frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
            
            
            
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
                setExamPayList(exam: examWithTitle.exam, premiumExams: premiumExams)
        }.onChange(of: examPaymentList){previous, current in
            totalPrice = getTotalPrice()
        }
    }
    
    
    private func getTotalPrice() -> Int{
        
        let list = getSelectedExamPay()
        
        if(list.isEmpty){
            return 0
        }
        
        var result = 0
        for item in list {
            result += item.exam.price
        }
        
        return result
        
        
    }
    
   private func getSelectedExamPay() -> [ExamPay] {
        
        return examPaymentList.filter { $0.isSelected }
        
    }
    
    func setExamPayList(exam: Exam, premiumExams: [Exam]) {
        
        examPaymentList = premiumExams.map { item in
            if item.examId == exam.examId {
                return ExamPay(exam: item, isSelected: true)
            } else {
                return ExamPay(exam: item, isSelected: false)
            }
        }
        
        examPaymentList.sort { !$0.isSelected && $1.isSelected }
    }
}

#Preview {
    
    let exam = Exam(cbtId: "1", subcatId: "2", numQuestions: 4, price: 300, title: "Geography", instruction: "Do your best", description: "Welcome abroad", duration: 5, isActive: true, createdAt: "", sellerEmail: "", hasSample: true, examId: "2", isProvisioned: true, numViews: 3, isMaxAttempt: false, startTime: "", isCompulsory: "1")
    
    ExamPayBottomSheetView( examWithTitle: ExamWithTitle(exam: exam, title: "Biology"), premiumExams: [exam, exam], onClose: {}, onPaymentClicked: {examPay in }, onAddToCart: {examPay in })
}
