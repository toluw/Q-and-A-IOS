//
//  CatScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 25/05/2026.
//

import SwiftUI

struct CatScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    @ObservedObject var paymentViewModel: PaymentViewModel
    @StateObject var viewModel: CatViewModel = .init()
    
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
                               
                                Text("Select preffered \(cbtViewModel.parentCategoriesData?.catData?.examType.lowercased() ?? "")")
                                    .font(AppFont.regular(16))
                                    .padding(.top, 16)
                                
                                
                                TextField("Search \(cbtViewModel.parentCategoriesData?.catData?.examType.lowercased() ?? "")", text: $viewModel.state.searchText)
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
                                           
                                           CatExamItemView(catExam: $viewModel.state.items[index], catData: catData, viewModel: viewModel, position: index, onRequestPayment: {premExam in
                                               
                                               handlePaymentRequest(premExam: premExam)
                                               
                                           }, onPractice: {
                                               practice()
                                           })
                                           
                                           
                                           
                                           
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
            .onAppear{
                      viewModel.reInitExamSelection()
                      
                   if let cbtId = (cbtViewModel.parentCategoriesData?.catData?.cbtId){
                       viewModel.getSubCatExams(cbtId: cbtId, buyerEmail: UserSettings.email)
                      }
                      
            }.onChange(of: viewModel.state.searchText){previous, newValue in
               
                search(newValue: newValue)
                
            }.sheet(isPresented: $viewModel.state.showPaymentSheet){
                
                if(viewModel.premExam != nil){
                    
                    ExamPayBottomSheetView(
                        examWithTitle: ExamWithTitle(exam: viewModel.premExam!.exam, title: cbtViewModel.parentCategoriesData?.item ?? ""),
                      premiumExams: viewModel.premExam!.premiumExams,
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
                        
                        
                    }).presentationDetents([.medium,  .large])
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
                          
                       }
                       
                   )
               }
            .onChange(of: viewModel.state.multipleExamData){oldValue, newValue in
              
                if(!viewModel.state.multipleExamData.isEmpty){
                    
                    cbtViewModel.initMultipleExams(multipleExamQuestions: viewModel.state.multipleExamData, examSelectList: cbtViewModel.examSelectList)
                    
                    cbtViewModel.initIndexList()
                    
                    navVm.navigate(route: .examPracticeScreen)
                }
            }
          
           
          
        
            
          
    }
    
    
    private func handlePaymentRequest(premExam: PremExam){
        if(!UserSettings.isLoggedIn){
            viewModel.showLogin = true
        }else{
            viewModel.premExam = premExam
            viewModel.state.showPaymentSheet = true
        }
    }
    
    
    private func search(newValue: String){
        if(newValue == ""){
            viewModel.state.items = viewModel.state.initItems
        }else{
            
            let searchData = viewModel.state.initItems.filter {
                $0.exam.title.lowercased().contains(newValue.lowercased())
                
            }
            
            viewModel.state.items = searchData
            
            if(searchData.isEmpty){
                viewModel.state.emptyStateText = "No search result for \(newValue)"
            }
            
            
            
        }
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
    
    private func setExamList(){
        
        cbtViewModel.examSelectList = viewModel.getExamSelectList(category: cbtViewModel.parentCategoriesData?.item ?? "",image: cbtViewModel.parentCategoriesData?.catData?.image, disableReview: cbtViewModel.parentCategoriesData?.catData?.disableReview ?? false)
        
        cbtViewModel.examIndex = 0
        
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
    
    
    private func handleQuestionSelection(numQuestion: Int){
        
        if let position = viewModel.state.selectQuestion?.position{
            
            
            viewModel.state.items[position].questionText = String(numQuestion)
            
            let initPos = viewModel.getInitPosition(catExams: viewModel.state.items[position])
            
            if let pos = initPos {
                viewModel.state.initItems[pos].questionText = String(numQuestion)
            }
            
            
            
            viewModel.updateExamSelect(examId: viewModel.state.items[position].exam.examId, numQuestion: numQuestion)
        }
        
        
        
    }
    
    
    
    
        
}

#Preview {
    CatScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), paymentViewModel: PaymentViewModel())
}
