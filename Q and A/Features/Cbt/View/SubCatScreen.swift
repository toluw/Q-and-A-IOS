//
//  SubCatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 17/04/2026.
//

import SwiftUI

struct SubCatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @StateObject var viewModel: SubCatViewModel = .init()
    
    var body: some View {
        
        
        ZStack{
            
            if(viewModel.state.isLoading){
                
                ProgressView()
                
            }else{
                if(viewModel.state.errorMessage != nil){
                    
                    ErrorView(message: viewModel.state.errorMessage!){
                        if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                            viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                           }
                    }
                    
                }else{
                    
                    ScrollView{
                        
                        LazyVStack(spacing: 0){
                            
                            VStack{
                               
                                Text("Select preffered \(cbtViewModel.parentCategoriesData?.catData?.subcatType.lowercased() ?? "")")
                                    .font(AppFont.regular(16))
                                    .padding(.top, 16)
                                
                                
                                TextField("Search \(cbtViewModel.parentCategoriesData?.catData?.subcatType.lowercased() ?? "")", text: $viewModel.state.searchText)
                                    .padding(.leading,20)
                                    .padding(.trailing,20)
                                    .padding(.top, 12)
                                    .padding(.bottom, 12)
                                    .textFieldStyle(.roundedBorder)
                                
                            }.frame(maxWidth: .infinity)
                                .background(.white)
                            
                         
                            
                            if(viewModel.state.items.isEmpty){
                                
                                EmptyStateView(title: viewModel.state.emptyStateText)
                                    .padding(.leading, 16)
                                    .padding(.trailing,16)
                                    .padding(.top, 35)
                                
                            }else{
                                ForEach(viewModel.state.items.indices, id: \.self) { index in
                                       
                                       if let catData = cbtViewModel.parentCategoriesData?.catData {
                                           SubCatExamItemView(
                                               subCatExam: $viewModel.state.items[index],
                                               catData: catData,
                                               viewModel: viewModel,
                                               position: index
                                           )
                                       }
                            } .padding(.leading, 16)
                                    .padding(.trailing, 16)
                                    .padding(.top, 30)
                                
                                Spacer()
                                        .frame(height: 170)
                            
                            
                               
                        }
            
                       
                            
                            
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color("list_bg"))
                    
                }
                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
          .onAppear{
                    viewModel.reInitExamSelection()
                    
                 if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                     viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                    }
                    
                }
        
          .onChange(of: viewModel.state.searchText){oldValue, newValue in
              if(newValue == ""){
                  viewModel.state.items = viewModel.state.initItems
              }else{
                  
                  let searchData = viewModel.state.initItems.filter {
                      $0.data.item.lowercased().contains(newValue.lowercased())
                  }
                  
                  viewModel.state.items = searchData
                  
                  if(searchData.isEmpty){
                      viewModel.state.emptyStateText = "No search result for \(newValue)"
                  }
                  
                  
                  
              }
          }
        
          .sheet(isPresented: $viewModel.showExamSelectSheet){
              
             if(viewModel.state.selectExam != nil){
                  ExamSelectBottomSheetView(selectExam: viewModel.state.selectExam!, onExamSelected: {examWithTitle in
                      
                      viewModel.showExamSelectSheet = false
                      
                      if(examWithTitle.exam.isProvisioned){
                          handleExamSelection(examWithTitle: examWithTitle)
                      }else{
                         
                          
                      }
                      
                      
                      }
                  ).presentationDetents([.large])
              }
             
          }
          .onChange(of: viewModel.state.examSelectList){oldValue, newValue in
              
              if(!viewModel.state.examSelectList.isEmpty && cbtViewModel.parentCategoriesData?.catData?.disablePractice == true){
                  
                  practice()
                  
              }
              
          }
          
         
          }
        
        
        
        
        
    
    private func practice(){
        
    }
    
    
    private func selectExam(position: Int, exam: Exam){
        
        let item = viewModel.state.items[position]

        if !viewModel.state.examSelectList
            .map({ $0.subcatId })
            .contains(item.data.subcatId) {
            
            let newItem = SubCatExamSelect(
                cbtId: item.data.cbtId,
                item: item.data.item,
                subcatId: item.data.subcatId,
                exam: exam,
                numQuestions: exam.numQuestions,
                shouldShuffle: viewModel.state.items[position].isShuffle,
                disableReview: cbtViewModel.parentCategoriesData?.catData?.disableReview ?? false
            )
            
            viewModel.state.examSelectList.append(newItem)
            
        } else {
            viewModel.updateExamSelect(
                subCatId: item.data.subcatId,
                exam: exam
            )
        }
        
        viewModel.state.items[position].yearText = exam.title
        
        if(UserSettings.isLoggedIn){
            viewModel.state.items[position].showShuffle = true
        }
        
        viewModel.state.items[position].defaultQuestions = exam.numQuestions
        viewModel.state.items[position].questionText = String(exam.numQuestions)
        viewModel.state.items[position].numViews = String(exam.numViews)
        viewModel.state.items[position].showQuestionLayout = true
        
        let initPos = viewModel.getInitPosition(subCatExams: viewModel.state.items[position])
        
        if let pos = initPos {
            viewModel.state.initItems[pos].yearText = exam.title
            viewModel.state.initItems[pos].defaultQuestions = exam.numQuestions
            viewModel.state.initItems[pos].numViews = String(exam.numViews)
            viewModel.state.initItems[pos].showQuestionLayout = true
            
        }
        
        
        
        
        
        
    }
    
    
    private func handleExamSelection(examWithTitle: ExamWithTitle){
        
        if(examWithTitle.exam.startTime != ""){
            if(isTimeInTheFuture(examWithTitle.exam.startTime)){
               let examName = cbtViewModel.parentCategoriesData?.catData?.examType  ?? "test"
                
                let message = "This exam starts at \(examWithTitle.exam.startTime). Champ! You don't want to miss it. Set a Reminder"
                
                showErrorMessage(message: message, actionTitle: "Close", showCancel: false, action: {})
                
                return
            }
        }
        
        if(examWithTitle.exam.isMaxAttempt){
            
            let message = "Oops! You have exceeded the maximum attempt for this \(cbtViewModel.parentCategoriesData?.catData?.examType ?? "test") "
            
            showErrorMessage(message: message, actionTitle: "Close", showCancel: false, action: {})
            
            return
            
        }
        
        
        if let position =  viewModel.state.selectExam?.position{
            selectExam(position: position, exam: examWithTitle.exam)
        }
        
        
        
    }
}

#Preview {
    SubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel())
}
