//
//  ReviewExamScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 16/06/2026.
//

import SwiftUI

struct ReviewExamScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let examId: String
    @StateObject var viewModel: ReviewViewModel = .init()
    
    var body: some View {
        ZStack{
            
            if let liveExamBinding = $cbtViewModel.reviewExam.unwrap(){
                ReviewExamView(questionCount: cbtViewModel.reviewExamList.count, questionIndex: $cbtViewModel.reviewIndex, liveExam: liveExamBinding, examState: $viewModel.state, numNotice: viewModel.numNotice,
                 next: {
                    cbtViewModel.nextReview()
                    viewModel.reInitState()
                }, previous: {
                    cbtViewModel.previousReview()
                    viewModel.reInitState()
                    
                }, gotTo: {
                    viewModel.state.showGoToBottomSheet = true
                }, close: {
                    showErrorMessage(message: "Are you sure you want to exit?", actionTitle: "Exit", showCancel: true, action: {
                        exit()
                    })
                }, readMorePassage: {
                    readMorePassage()
                }, onAskAi: {
                    askAi()
                }, onJoinDiscussion: {
                    joinDiscussion()
                }, onNoticeClicked: joinDiscussion).id(liveExamBinding.id)
                    .transition(cbtViewModel.transition)
            }
            
            if(viewModel.state.showLoader){
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                ProgressView()
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                getNumPost()
            }
            .sheet(isPresented: $viewModel.state.showGoToBottomSheet){
                GoToReviewBottomSheetView(fullQuestionList: cbtViewModel.reviewExamList.goToReviewList(), onQuestionSelected: {data in
                    
                    cbtViewModel.goToReview(index: data.questionIndex)
                    
                    viewModel.reInitState()
                    
                    viewModel.state.showGoToBottomSheet = false
                      
                })
            }
            .onChange(of: viewModel.aiContent) { _,  content in
            
                if(!content.isEmpty){
                    viewModel.aiContent = ""
                    navVm.navigate(route: .aiCbtScreen(content: content))
                }
               
                
            }
            .onChange(of: cbtViewModel.reviewExam){_, _ in
                getNumPost()
            }
            
    }
    
    private func joinDiscussion(){
        navVm.navigate(route: .cbtPostScreen(examId: examId, liveExam: cbtViewModel.reviewExamList[cbtViewModel.reviewIndex]))
    }
    
    private func askAi(){
        
        let liveExam = cbtViewModel.reviewExamList[cbtViewModel.reviewIndex]
        let askAiCbtBody = AskAiCbtBody(exam_id: examId, question_id: liveExam.questionId)
        viewModel.askAiCbt(askAiCbtBody: askAiCbtBody)
        
    }
    
    private func getNumPost(){
        let liveExam = cbtViewModel.reviewExamList[cbtViewModel.reviewIndex]
        viewModel.getNumPost(examId: examId, questionId: liveExam.questionId)
    }
    
    private func readMorePassage(){
        
        
          let passage = cbtViewModel.reviewExamList[cbtViewModel.questionIndex].passage
               let passageImage = cbtViewModel.reviewExamList[cbtViewModel.questionIndex].passageImage
               let passageVideo = cbtViewModel.reviewExamList[cbtViewModel.questionIndex].passageVideo
               let passageBook = cbtViewModel.reviewExamList[cbtViewModel.questionIndex].passageBook
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
            print("show=>show_full_message")
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
    
    private func exit(){
        navVm.pop()
    }
}

#Preview {
    ReviewExamScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(), examId: "")
}
