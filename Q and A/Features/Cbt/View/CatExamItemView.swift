//
//  CatExamItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 26/05/2026.
//

import SwiftUI

struct CatExamItemView: View {
    
    @Binding var catExam: CatExams
    let catData: CatData
    @ObservedObject var viewModel: CatViewModel
    let position: Int
    let onRequestPayment: (PremExam) -> Void
    let onPractice: () -> Void
    
    
    var body: some View {
        
        
        Button(action: {
            setCheck()
        }){
            VStack{
                
                HStack{
                    
                    LoadImageView(url: catData.image, width: 56 , height: 56)
                        .padding(.trailing, 10)
                    
                    Spacer()
                    
                    Text(catExam.exam.title)
                        .font(AppFont.semi_bold(18))
                    
                    Spacer()
                    
                    
                    ZStack{
                        if(catExam.isChecked){
                            Image("check")
                        }else{
                            Image("uncheck")
                        }
                    }.padding(.leading, 10)
                    
                    
                    
                   
                    
                }.padding(.top,15)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                
                
                if(catExam.isChecked){
                    bottomView().padding(.top, 19)
                }
                
                Spacer().frame(height: 19)
                
                
            }.frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
            .onChange(of: catExam.isShuffle){oldValue, newValue in
                
                let initPos = viewModel.getInitPosition(catExams: catExam)
                
                if let pos = initPos {
                    viewModel.state.initItems[pos].isShuffle = !viewModel.state.initItems[pos].isShuffle
                    
                }
                
                viewModel.updateExamSelect(examId: catExam.exam.examId, shouldShuffle: newValue)
                
                
                
            }
        
    }
    
    
    private func setCheck(){
        if(catExam.exam.isProvisioned){
            
            let examList: [Exam] = viewModel.state.items.map{item in
                item.exam
            }
            
            let premiumExams = examList.filter{exam in
                !exam.isProvisioned
            }
            
            let premExam = PremExam(premiumExams: premiumExams, exam: catExam.exam)
            
            onRequestPayment(premExam)
            
            return
            
        }
        
        if(catExam.exam.startTime != ""){
            if(isTimeInTheFuture(catExam.exam.startTime)){
             //  let examName = cbtViewModel.parentCategoriesData?.catData?.examType  ?? "test"
                
                let message = "This exam starts at \(catExam.exam.startTime). Champ! You don't want to miss it. Set a Reminder"
                
                showErrorMessage(message: message, actionTitle: "Close", showCancel: false, action: {})
                
                return
            }
        }
        
        if(catExam.exam.isMaxAttempt){
            
            let message = "Oops! You have exceeded the maximum attempt for this \(catData.examType) "
            
            showErrorMessage(message: message, actionTitle: "Close", showCancel: false, action: {})
            
            return
            
        }
        
        if(catExam.isChecked){
            catExam.isChecked = false
            let initPos = viewModel.getInitPosition(catExams: catExam)
            
            if let pos = initPos{
                viewModel.state.initItems[pos].isChecked = false
            }
            
            deselectExam()
            
        }else{
            
            if(viewModel.state.examSelectList.count >= catData.maxExams){
                let errorMessage = if(catData.maxExams > 1){
                                          "You cannot attempt more than \(catData.maxExams) exams at a time"
                                      }else{
                                          "You cannot attempt more than \(catData.maxExams) exam at a time"
                                      }
                
                showErrorMessage(message: errorMessage, actionTitle: "Close", showCancel: false, action: {})
            }else{
                
                if(catData.disablePractice){
                    selectExam()
                    onPractice()
                    return
                }
                
                catExam.isChecked = true
                
                let initPos = viewModel.getInitPosition(catExams: catExam)
                
                if let pos = initPos{
                    
                    viewModel.state.initItems[pos].isChecked = true
                    
                }
                
                selectExam()
                
                
            }
            
        }
        
        
    }
    
    
    private func deselectExam(){
        
        viewModel.state.examSelectList = viewModel.state.examSelectList.filter{
            $0.exam.examId != catExam.exam.examId
        }
        
        catExam.questionText = ""
        catExam.numViews = ""
        catExam.isChecked = false
        catExam.isShuffle = false
        
        let initPos = viewModel.getInitPosition(catExams: catExam)
        
        if let pos = initPos{
            viewModel.state.initItems[pos].questionText = ""
            viewModel.state.initItems[pos].numViews = ""
            viewModel.state.initItems[pos].isChecked = false
            viewModel.state.initItems[pos].isShuffle = false
        }
        
        
    }
    
    private func selectExam(){
        
        viewModel.state.examSelectList.append(CatExamSelect(exam: catExam.exam, numQuestions: catExam.exam.numQuestions, shouldShuffle: catExam.isShuffle))
        
        catExam.defaultQuestions = catExam.exam.numQuestions
        catExam.numViews = String(catExam.exam.numViews)
        catExam.questionText = String(catExam.exam.numQuestions)
        
        let initPos = viewModel.getInitPosition(catExams: catExam)
        
        if let pos = initPos{
            viewModel.state.initItems[pos].defaultQuestions = catExam.exam.numQuestions
            viewModel.state.initItems[pos].numViews = String(catExam.exam.numViews)
            viewModel.state.initItems[pos].questionText = String(catExam.exam.numQuestions)
        }
        
        
        
        
        
        
        
    }
    
    private func bottomView() -> some View{
        VStack{
            
            VStack(alignment: .leading){
                Text("No of Question")
                    .font(AppFont.medium(16))
                
                DropDownInput(text: $catExam.questionText, hint: "Select", onItemClicked: {
                    selectQuestion()
                }).padding(.top, 2)
            }.padding(.leading,10).frame(maxWidth: .infinity)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            
            
                HStack{
                    
                    HStack{
                        Image("eye")
                        Text(catExam.numViews)
                            .foregroundColor(Color("faint"))
                            .font(AppFont.regular(14))
                            .padding(.leading, 7)
                        
                        Spacer()
                        
                        
                            CheckBox(isChecked: $catExam.isShuffle, title: "Shuffle Questions")
                        
                        
                                
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.top, 19)
            
            
        }
    }
    
    private func selectQuestion(){
        print("selector","select question")
        viewModel.state.selectQuestion = SelectQuestion(position: position, numQuestion: catExam.defaultQuestions)
        
        viewModel.showQuestionSelectSheet = true
    }
    
}


#Preview {
    CatExamItemViewPreveiwWrapper()
}


struct CatExamItemViewPreveiwWrapper: View {
    
    @State private var catExam: CatExams
    let catData: CatData
    
    
    init(){
        
        let ex = Exam(cbtId: "2", subcatId: "4", numQuestions: 4, price: 500, title: "Map", instruction: "Wao", description: "Meet them", duration: 9, isActive: true, createdAt: "", sellerEmail: "qapp", hasSample: true, examId: "e", isProvisioned: true, numViews: 4, isMaxAttempt: true, startTime: "trie", isCompulsory: "1")
        
        var examList: [Exam] { [ex, ex, ex, ex] }
        
        let subCategoryData = SubCategoryData(
            cbtId: "",
            item: "Bag",
            createdAt: "",
            isActive: true,
            subcatId: "",
            exams: examList
        )
        
        catExam = CatExams(exam: ex)
    
        
        catData = CatData(cbtId: "", subcat: [], isActive: true, createdAt: "", maxExams: 3, examType: "Year", subcatType: "Subject", image: "", maxAttempt: 1, disablePractice: true, disableReview: true, hasObjective: true, hasTheory: false, isMock: true, minimumPurchase: 500, mockDescription: "", startDate: nil, endTime: "", startTime: "", mockParent: nil, prizeMoney: 500, sponsor: Sponsor(id: "", name: "Emmanuel", website: "",  facebook: nil, instagram: nil, twitter: nil, tiktok: nil, linkedin : nil, createdAt : "", sponsorImage :nil))
                                                                                                 
                                                                                                                                                                                                                                                                                                                                                            }
    
    
    var body: some View {
        
        
        
        CatExamItemView(catExam: $catExam, catData: catData, viewModel: CatViewModel(), position: 0, onRequestPayment: {data in}, onPractice:  {})
    }
    
}

