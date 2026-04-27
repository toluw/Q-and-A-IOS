//
//  SubCatExamItemView.swift
//  Q and A
//
//  Created by GIGL-PC on 22/04/2026.
//

import SwiftUI

struct SubCatExamItemView: View {
    
    @Binding var subCatExam: SubCatExams
    let catData: CatData
    @ObservedObject var viewModel: SubCatViewModel
    let position: Int
    
    
    
    
   
    
    var body: some View {
        
        
        Button(action: {
            setCheck()
        }){
            VStack{
                
                HStack{
                    
                    LoadImageView(url: catData.image, width: 56 , height: 56)
                        .padding(.trailing, 10)
                    
                    Spacer()
                    
                    Text(subCatExam.data.item)
                        .font(AppFont.semi_bold(18))
                    
                    Spacer()
                    
                    
                    ZStack{
                        if(subCatExam.isChecked){
                            Image("check")
                        }else{
                            Image("uncheck")
                        }
                    }.padding(.leading, 10)
                    
                    
                    
                   
                    
                }.padding(.top,15)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                
                
                if(subCatExam.isChecked){
                    bottomView().padding(.top, 19)
                }
                
                Spacer().frame(height: 19)
                
                
            }.frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
            .onChange(of: subCatExam.isShuffle){oldValue, newValue in
                
                let initPos = viewModel.getInitPosition(subCatExams: subCatExam)
                
                if let pos = initPos {
                    viewModel.state.initItems[pos].isShuffle = !viewModel.state.initItems[pos].isShuffle
                    
                }
                
                viewModel.updateExamSelect(subCatId: subCatExam.data.subcatId, shouldShuffle: subCatExam.isShuffle)
                
                
                
            }
         
        
       
        
    }
    
    private func setCheck(){
        if(subCatExam.isChecked){
            subCatExam.isChecked = false
            subCatExam.showQuestionLayout = false
            let initPos = viewModel.getInitPosition(subCatExams: subCatExam)
            if let pos = initPos {
                viewModel.state.initItems[pos].isChecked = false
            }
            deselectExam()
            
        }else{
           
            if(viewModel.state.examSelectList.count >= catData.maxExams){
                viewModel.state.maxExamSelectedMessage = catData.maxExams > 1 ? "You cannot attempt more than \(catData.maxExams) exams at a time" : "You cannot attempt more than \(catData.maxExams) exam at a time"
            }else{
                subCatExam.isChecked = true
                subCatExam.showShuffle = false
                let initPos = viewModel.getInitPosition(subCatExams: subCatExam)
                if let pos = initPos{
                    viewModel.state.initItems[pos].isChecked = true
                }
                
                
            }
            
        }
    }
    
    private func deselectExam(){
        
        let subCatId = subCatExam.data.subcatId
        
        viewModel.state.examSelectList = viewModel.state.examSelectList.filter { $0.subcatId != subCatId }
        
        subCatExam.yearText = ""
        subCatExam.questionText = ""
        subCatExam.numViews = ""
        subCatExam.isChecked = false
        subCatExam.isShuffle = false
        
        let initPos = viewModel.getInitPosition(subCatExams: subCatExam)
        
        if let pos = initPos{
            
            viewModel.state.initItems[pos].yearText = ""
            viewModel.state.initItems[pos].questionText = ""
            viewModel.state.initItems[pos].numViews = ""
            viewModel.state.initItems[pos].isChecked = false
            viewModel.state.initItems[pos].isShuffle = false
            
        }
        
        
        
        
        
        
    }
    
    
    private func selectYear(){
        viewModel.state.selectExam = SelectExam(exams: subCatExam.data.exams, position: position, title: subCatExam.data.item)
        viewModel.state.showExamSelectSheet = true
    }
    
    private func selectQuestion(){
        viewModel.state.selectQuestion = SelectQuestion(position: position, numQuestion: subCatExam.defaultQuestions)
    }
    
    
    private func bottomView() -> some View{
        VStack{
            
            HStack{
                
                
                VStack(alignment: .leading){
                    
                    Text(catData.examType.capitalizeWords())
                        .font(AppFont.medium(16))
                    
                    DropDownInput(text: $subCatExam.yearText, hint: "Select \(catData.examType.capitalizeWords())", onItemClicked: {
                        
                        
                        
                    }).padding(.top, 2)
                    
                }
                
                if(subCatExam.showQuestionLayout){
                    
                    VStack(alignment: .leading){
                        Text("No of Question")
                            .font(AppFont.medium(16))
                        
                        DropDownInput(text: $subCatExam.questionText, hint: "Select", onItemClicked: {
                            selectQuestion()
                        }).padding(.top, 2)
                    }.padding(.leading,10)
                    
                }
                    
                
                
                
                  
                
            }.frame(maxWidth: .infinity)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            
            if(subCatExam.showQuestionLayout){
                HStack{
                    
                    HStack{
                        Image("eye")
                        Text(subCatExam.numViews)
                            .foregroundColor(Color("faint"))
                            .font(AppFont.regular(14))
                            .padding(.leading, 7)
                        
                        Spacer()
                        
                        if(subCatExam.showShuffle){
                            CheckBox(isChecked: $subCatExam.isShuffle, title: "Shuffle Questions")
                        }
                        
                                
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                    .padding(.top, 19)
            }
            
        }
    }
    
}




#Preview {
    SubCatExamItemViewPreveiwWrapper()
}


struct SubCatExamItemViewPreveiwWrapper: View {
    
    @State private var subCatExam: SubCatExams
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
        
        subCatExam = SubCatExams(data: subCategoryData, isChecked: true, showQuestionLayout: false)
    
        
        catData = CatData(cbtId: "", subcat: [], isActive: true, createdAt: "", maxExams: 3, examType: "Year", subcatType: "Subject", image: "", maxAttempt: 1, disablePractice: true, disableReview: true, hasObjective: true, hasTheory: false, isMock: true, minimumPurchase: 500, mockDescription: "", startDate: nil, endTime: "", startTime: "", mockParent: nil, prizeMoney: 500, sponsor: Sponsor(id: "", name: "Emmanuel", website: "",  facebook: nil, instagram: nil, twitter: nil, tiktok: nil, linkedin : nil, createdAt : "", sponsorImage :nil))
                                                                                                 
                                                                                                                                                                                                                                                                                                                                                            }
    
    
    var body: some View {
        
        
        
        SubCatExamItemView(subCatExam: $subCatExam, catData: catData, viewModel: SubCatViewModel(), position: 0)
    }
    
}
