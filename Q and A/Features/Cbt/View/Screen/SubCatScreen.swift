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
    @ObservedObject var paymentViewModel: PaymentViewModel
    @StateObject var viewModel: SubCatViewModel = .init()
    
    var body: some View {
        
        
        ZStack{
            
            if(viewModel.state.isLoading){
                
                ProgressView()
                
            }else{
                if(viewModel.state.errorMessage != nil){
                    
                    ErrorView(message: viewModel.state.errorMessage!){
                        if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                            Task{
                              await  viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                            }
                            
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
            
            if(!viewModel.state.examSelectList.isEmpty){
                
                continueCard()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 18)
                    .padding(.horizontal, 12)
                
            }
            
            if viewModel.state.showBlockedLoader {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   ProgressView()
                       .padding()
                       .background(Color.white)
                       .cornerRadius(10)
               }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
       .onChange(of: navVm.activeRoute){_, route in
           
           //Reload data when resume back from stack
           
           
              
                if (route != .examSubCatScreen)
                {
                    return
                    
                }
           
         
                viewModel.reInitExamSelection()
                
                if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                    Task{
                       await viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                    }
                 
                }
                
            
            }
       
        
        .task {
            
            //Load data when screen is first created
            
          
            
            if(navVm.activeRoute != .examSubCatScreen){
                return
            }
            
           
            viewModel.reInitExamSelection()
            
            if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                
                   await viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                
             
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
        
          .sheet(isPresented: $viewModel.state.showPaymentSheet){
              if(viewModel.state.selectExam != nil && viewModel.state.examWithTitle != nil){
                  
                  ExamPayBottomSheetView(
                    examWithTitle: viewModel.state.examWithTitle!,
                    premiumExams: viewModel.state.selectExam!.exams.filter { !$0.isProvisioned },
                    onClose: {
                      viewModel.state.showPaymentSheet = false
                  }, onPaymentClicked: {items in
                      viewModel.state.showPaymentSheet = false
                      cbtViewModel.selectedExamPay = items
                      paymentViewModel.paymentState = .initialize
                      navVm.navigate(route: .cbtPaymentScreen)
                  }, onAddToCart: {
                      viewModel.state.showPaymentSheet = false
                      navVm.navigate(route: .cbtCartScreen)
                  }).presentationDetents([.large])
                  
              }
              
          }
        
          .sheet(isPresented: $viewModel.showExamModeSheet){
              
              SelectCbtModeView(){cbtMode in
                 
                  viewModel.showExamModeSheet = false
                  setExamList()
                  
                  if(cbtMode == .practice){
                     practice()
                  }else if(cbtMode == .exam){
                     examMode()
                  }
                  
                  
              }.presentationDetents([.medium])
              
          }
        
          .sheet(isPresented: $viewModel.showQuestionSelectSheet){
              
              if(viewModel.state.selectQuestion != nil){
                  
                  QuestionBottomSheetView(selectQuestion: viewModel.state.selectQuestion!, onClick: {
                      question in
                      
                      viewModel.showQuestionSelectSheet = false
                      
                      handleQuestionSelection(numQuestion: question)
                      
                      
                  }).presentationDetents([.large])
              }
              
          }
        
          .sheet(isPresented: $viewModel.showLogin){
                 LoginScreen(
                     onDismiss: {
                         viewModel.showLogin = false
                     }, onForgotpassword: {
                         viewModel.showLogin = false
                         navVm.navigate(route: .forgotPasswordScreen)
                     }, onLoginSuccess: {userProfile in
                         viewModel.showLogin = false
                         showSuccessMessage(message: "Thanks \(userProfile.name)! You are now logged in", actionTitle: "Continue", showCancel: false){
                             
                         }
                        
                     },
                     navVM: navVm
                     
                 )
             }
        
          .sheet(isPresented: $viewModel.showExamSelectSheet){
              
             if(viewModel.state.selectExam != nil){
                  ExamSelectBottomSheetView(selectExam: viewModel.state.selectExam!, onExamSelected: {examWithTitle in
                      
                      viewModel.showExamSelectSheet = false
                      
                      if(examWithTitle.exam.isProvisioned){
                          handleExamSelection(examWithTitle: examWithTitle)
                      }else{
                         handlePaymentIntent(examWithTitle: examWithTitle)
                      }
                      
                      
                      }
                  ).presentationDetents([.large])
              }
             
          }
          .onChange(of: viewModel.state.multipleExamData){oldValue, newValue in
            
              if(!viewModel.state.multipleExamData.isEmpty){
                  
                  cbtViewModel.initMultipleExams(multipleExamQuestions: viewModel.state.multipleExamData, examSelectList: cbtViewModel.examSelectList)
                  
                  cbtViewModel.initIndexList()
                  
                  viewModel.state.multipleExamData = []
                  
                  navVm.navigate(route: .examPracticeScreen)
              }
          }
          .onChange(of: viewModel.state.examSelectList){oldValue, newValue in
              
              if(!viewModel.state.examSelectList.isEmpty && cbtViewModel.parentCategoriesData?.catData?.disablePractice == true){
                  
                  setExamList()
                  
                  practice()
                  
              }
              
          }
          
         
          }
        
    
    
    private func setExamList(){
        
        cbtViewModel.examSelectList = viewModel.getExamSelectList(category: cbtViewModel.parentCategoriesData?.item ?? "",image: cbtViewModel.parentCategoriesData?.catData?.image)
        
        cbtViewModel.examIndex = 0
        
    }
        
      
   
    @ViewBuilder
    private func continueCard() -> some View{
        
        
    
        VStack{
            
            Text("(\(viewModel.state.examSelectList.count))  \(cbtViewModel.parentCategoriesData?.catData?.subcatType.capitalizeWords() ?? "") selected")
                .foregroundColor(Color.white)
                .font(AppFont.medium(16))
                .padding(.top, 23)
            
            Button(action: {
                
                viewModel.showExamModeSheet = true
                
            }){
                ZStack{
                    
                    Text("Continue \(viewModel.state.examSelectList.count)")
                        .foregroundColor(Color.white)
                        .font(AppFont.medium(16))
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .padding(.leading, 34)
                        .padding(.trailing, 34)
                        .contentShape(Rectangle())
                        
                    
                }.background(Color("continue_btn_color"))
                    .cornerRadius(4)
            }.buttonStyle(.plain)
                .padding(.bottom, 23)
                .padding(.top, 21)
            
            
        }.frame(maxWidth: .infinity)
            .background(Color("bg_continue"))
            .cornerRadius(20)
    
    }
        
    
    private func practice(){
        
        let multipleExamBody = cbtViewModel.getMultipleExamBody(examSelectList: cbtViewModel.examSelectList, buyerEmail: UserSettings.email ?? "")
        
        viewModel.getMultipleExam(multipleExamBody: multipleExamBody)
        
    }
    
    private func examMode(){
        cbtViewModel.examResultDataList = []
        cbtViewModel.examIndex = 0
        navVm.navigate(route: .examDescriptionScreen)
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
    
    private func handleQuestionSelection(numQuestion: Int){
        
        if let position = viewModel.state.selectQuestion?.position{
            
            
            viewModel.state.items[position].questionText = String(numQuestion)
            
            let initPos = viewModel.getInitPosition(subCatExams: viewModel.state.items[position])
            
            if let pos = initPos {
                viewModel.state.initItems[pos].questionText = String(numQuestion)
            }
            
            viewModel.updateExamSelect(subCatId: viewModel.state.items[position].data.subcatId, numQuestion: numQuestion)
        }
        
        
        
    }
    
    
    private func handlePaymentIntent(examWithTitle: ExamWithTitle){
        if(UserSettings.isLoggedIn){
            viewModel.state.examWithTitle = examWithTitle
            viewModel.state.showPaymentSheet = true
        }else{
            showNoticeMessage(message:  "You must be logged in to proceed", actionTitle: "Login", showCancel: true){
                viewModel.showLogin = true
            }
        }
    }
        
    
    
    private func handleExamSelection(examWithTitle: ExamWithTitle){
        
        if(examWithTitle.exam.startTime != ""){
            if(isTimeInTheFuture(examWithTitle.exam.startTime)){
             //  let examName = cbtViewModel.parentCategoriesData?.catData?.examType  ?? "test"
                
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
    SubCatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
