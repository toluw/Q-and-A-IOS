//
//  PracticeScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 30/06/2026.
//

import SwiftUI

struct PracticeScreen: View {
    
    let multipleExam: MultipleExam
    
    @StateObject var viewModel: PracticeScreenViewModel = .init()
    @ObservedObject var navVm: MainNavViewModel
    
    var body: some View {
        ZStack{
            if let liveExamBinding = $viewModel.liveExam.unwrap() {
               
                PracticeView(questionCount: viewModel.liveExamList.count, questionIndex: $viewModel.questionIndex, liveExam: liveExamBinding, examState: $viewModel.state,
                next: {
                    if(authorizeUser()){
                        viewModel.nextQuestion()
                        viewModel.reInitState()
                    }
                   
                },
                previous: {
                    if(authorizeUser()){
                        viewModel.previousQuestion()
                        viewModel.reInitState()
                    }
                }, gotTo: {
                    if(authorizeUser()){
                        viewModel.state.showGoToBottomSheet = true
                    }
                }, readMorePassage: {
                    readMorePassage()
                } ,onMultiSelect: { ans in
                    viewModel.multiSelect(ans: ans)
                }, onMultiDeselect: {ans in
                    viewModel.multiDeselect(ans: ans)
                }, onAnswerSelected: { ans in
                    viewModel.answerQuestion(ans: ans)
                }, onCalculatorClicked: {
                    viewModel.state.showCalculator = true
                }, onMoveToExplanation: { isViewSolution in
                    
                }) .id(liveExamBinding.id)
                 .transition(viewModel.transition)

                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $viewModel.state.showLogin){
                   LoginScreen(
                       onDismiss: {
                           viewModel.state.showLogin = false
                       }, onForgotpassword: {
                           viewModel.state.showLogin = false
                           navVm.navigate(route: .forgotPasswordScreen)
                       }, onLoginSuccess: {userProfile in
                           viewModel.state.showLogin = false
                           showSuccessMessage(message: "Thanks \(userProfile.name)! You are now logged in", actionTitle: "Continue", showCancel: false){
                               navVm.pop()
                           }
                          
                       }
                       
                   )
               }
            .sheet(isPresented: $viewModel.state.showCalculator){
                CalculatorView(onDismiss: {
                    viewModel.state.showCalculator = false
                })
            }
            .sheet(isPresented: $viewModel.state.showGoToBottomSheet){
                GoToQuestionBottomSheetView(fullQuestionList: viewModel.liveExamList.goToQuestionList(), onQuestionSelected: {data in
                    
                    viewModel.goToQuestion(index: data.questionIndex)
                    
                    viewModel.reInitState()
                    
                    viewModel.state.showGoToBottomSheet = false
                    
                })
            }.onAppear{
                viewModel.initLiveExam(liveExams: multipleExam.liveExamList)
                viewModel.updateLiveExam(liveExamUpdateMode: .normal)
            }
         
    }
    
    
    private func authorizeUser() -> Bool{
        if(viewModel.questionIndex >= 2 && !UserSettings.isLoggedIn){
            viewModel.state.showLogin = true
            return false
        }
        
        return true
    }
    
    private func readMorePassage(){
        
        
          let passage = viewModel.liveExamList[viewModel.questionIndex].passage
               let passageImage = viewModel.liveExamList[viewModel.questionIndex].passageImage
               let passageVideo = viewModel.liveExamList[viewModel.questionIndex].passageVideo
               let passageBook = viewModel.liveExamList[viewModel.questionIndex].passageBook
               let pdfFile = "\(passageBook?.extractGoogleDriveFileId() ?? "").pdf"
               let directDownloadLink = convertGoogleDriveLinkToDirect(passageBook)
        
        if(passageImage?.isEmpty ?? true && passage.count <= PASSAGE_NUM
                  && passageVideo?.isValidYouTubeUrl() != true && directDownloadLink == nil
                  ){
                  return
              }

        if(directDownloadLink != nil && passageVideo?.isValidYouTubeUrl() != true){
            viewPdf(pdfFile: pdfFile, directDownloadLink: directDownloadLink!)
        }
        else if(directDownloadLink != nil && passageVideo?.isValidYouTubeUrl() == true){
           viewPassage(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile)
        }
        else if(passageImage?.isEmpty == false){
            viewPassage(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile)
        }
        else if (passage.count > FULL_PASSAGE_NUM){
            viewPassage(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile)
        }else{
            
            viewModel.state.showFullPassage = true
            
        }
        
        
        
        
    }
    
    private func viewPassage(
          passage: String,
          passageImage: String?,
          passageBook: String?,
          passageVideo: String?,
          pdfFile: String
    ){
        navVm.navigate(route: .passageScreen(passage: passage, passageImage: passageImage, passageBook: passageBook, passageVideo: passageVideo, pdfFile: pdfFile))
    }
    
    
    private func viewPdf(pdfFile: String, directDownloadLink: String){
        
    }
    
}

#Preview {
    
    let multipleExam = MultipleExam(examId: "2", item: "Biology", liveExamList: [
        LiveExam.preview, LiveExam.preview, LiveExam.preview
    ])
    
    PracticeScreen(multipleExam: multipleExam, navVm: MainNavViewModel())
}
