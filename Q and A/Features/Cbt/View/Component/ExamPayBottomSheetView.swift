//
//  ExamPayBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 06/05/2026.
//

import SwiftUI
import SwiftData

struct ExamPayBottomSheetView: View {
    
    let examWithTitle: ExamWithTitle
    let premiumExams: [Exam]
    
    @State var examPaymentList: [ExamPay] = []
    @State var totalPrice: Int = 0
    @State var isSelectAll: Bool = false
    @State var errorMessage: ToastData? = nil
    
    let onClose: () -> Void
    
    let onPaymentClicked: ([ExamPay]) -> Void
    
    
    let onAddToCart: () -> Void
    
    @Environment(\.modelContext) private var context

    private var repository: ExamCartRepository {
        ExamCartRepository(context: context)
        }
    
    
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Button(action: {
              onClose()
            }){
               Image("app_close")
                    .padding(.leading, 20)
                    .padding(.top, 30)
            }
            
            HStack{
                
                Spacer()
                
                Text(examWithTitle.title)
                    .font(AppFont.regular(16))
                
                
                Spacer()
            }
            
            
            Button(action: {
              isSelectAll = !isSelectAll
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
                            processCart(examPayList: getSelectedExamPay())
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
        .toastBanner(toast: $errorMessage)
        .onChange(of: isSelectAll){previous, current in
            
            if(current){
                selectAllExams()
            }else{
                setExamPayList(exam: examWithTitle.exam, premiumExams: premiumExams)
            }
            
        }
    }
    
    
    private func processCart(examPayList: [ExamPay]){
        
        print(examPayList)
        
        let it = try? repository.getExams()
        
       
        
        if(it == nil || it?.isEmpty == true){
            addToCart(examPayList: examPayList)
            return
        }
        
        print(it!)
        
        if(isExamNotInCart(exams: it!, examPaymentList: examPayList)){
            addToCart(examPayList: examPayList)
        }
        
        
    }
    
    func isExamNotInCart(
        exams: [ExamCart],
        examPaymentList: [ExamPay]
    ) -> Bool {

        let examIds = exams.map { $0.examId }

        for examPay in examPaymentList {

            if examIds.contains(examPay.exam.examId) {

                showExamInCartDialog(exam: examPay.exam)

                return false
            }
        }

        return true
    }
    
    private func showExamInCartDialog(exam: Exam){
        
        errorMessage = ToastData(message: "You have already added \(exam.title) to your cart", type: .error)
        
        
    }
    
    private func addToCart(examPayList: [ExamPay]){
        let cartItems = addTitleToCartContent(examPayList: examPayList, title: examWithTitle.title)
        
        try? repository.insertExams(cartItems)
        
        onAddToCart()
        
        
    }
    
    private func addTitleToCartContent(examPayList: [ExamPay], title: String) -> [ExamCart]{
        
        var cartList: [ExamCart] = []
        
        for examPay in examPayList{
            
            let examCart = ExamCart(cbtId: examPay.exam.cbtId, subcatId: examPay.exam.subcatId, numQuestions: examPay.exam.numQuestions, price: examPay.exam.price, title: "\(title) - \(examPay.exam.title)", instruction: examPay.exam.instruction, examDescription: examPay.exam.description, duration: examPay.exam.duration, isActive: examPay.exam.isActive, createdAt: examPay.exam.createdAt, sellerEmail: examPay.exam.sellerEmail, hasSample: examPay.exam.hasSample, examId: examPay.exam.examId, isProvisioned: examPay.exam.isProvisioned, numViews: examPay.exam.numViews, isMaxAttempt: examPay.exam.isMaxAttempt, startTime: examPay.exam.startTime, isCompulsory: examPay.exam.isCompulsory)
            
            cartList.append(examCart)
        }
        
        return cartList
        
        
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
    
    func selectAllExams() {
        
            let newList = examPaymentList.map {
                var item = $0
                item.isSelected = true
                return item
            }

            examPaymentList = newList
        
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
        
        examPaymentList.sort { $0.isSelected && !$1.isSelected }
    }
}

#Preview {
    
    let exam = Exam(cbtId: "1", subcatId: "2", numQuestions: 4, price: 300, title: "Geography", instruction: "Do your best", description: "Welcome abroad", duration: 5, isActive: true, createdAt: "", sellerEmail: "", hasSample: true, examId: "2", isProvisioned: true, numViews: 3, isMaxAttempt: false, startTime: "", isCompulsory: "1")
    
    ExamPayBottomSheetView( examWithTitle: ExamWithTitle(exam: exam, title: "Biology"), premiumExams: [exam, exam], onClose: {}, onPaymentClicked: {examPay in }, onAddToCart: { })
}
