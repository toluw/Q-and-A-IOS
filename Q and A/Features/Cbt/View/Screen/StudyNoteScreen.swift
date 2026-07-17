//
//  StudyNoteScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 10/07/2026.
//

import SwiftUI

struct StudyNoteScreen: View {
    
    let title: String
    let passage: String
    let passageImage: String?
    let passageBook: String?
    let passageVideo: String?
    
    @ObservedObject var navVm: MainNavViewModel
    
    
    
    var body: some View {
        VStack{
            
            VStack{
                
                ScrollView{
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                       
                        // Header
                        VStack(alignment: .leading, spacing: 0) {
                            Text(title)
                                .font(AppFont.medium(19))
                                .foregroundColor(LessonColor.textPrimary)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 16)

                        Divider()
                            .background(LessonColor.border)
                        
                        
                        // Body
                        VStack(alignment: .leading, spacing: 24) {

                            InstructionCallout(text: passage)
                            
                            if(passageVideo?.isValidYouTubeUrl() == true){
                                VideoRow(title: "Video Overview", action: {
                                    moveToVideo(videoUrl: passageVideo!)
                                })
                            }
                            
                            if let bookUrl = passageBook{
                                
                                if(convertGoogleDriveLinkToDirect(bookUrl) != nil){
                                    StudyMaterialRow(action: {
                                        moveToBook(bookUrl: bookUrl)
                                    })
                                }
                                
                            }
                            
                           

                           

                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 18)
                        .padding(.bottom, 18)
                        
                    }
                }
                
                
                Divider()
                    .background(LessonColor.border)

                StudyNoteButton(
                    title: "Continue to questions",
                    action: continueToQuestions
                )
                .padding(14)
               
                
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LessonColor.surfaceWhite)
                .cornerRadius(20)
                .padding(.bottom,14)
                .padding(.top,5)
                .padding(.horizontal,14)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LessonColor.itemBg)
    }
    
    
    private func moveToVideo(videoUrl: String){
        navVm.navigate(route: .youtubePlayerScreen(videoURLString: videoUrl))
    }
    
    
    private func moveToBook(bookUrl:String){
        if let remoteLink = URL(string: convertGoogleDriveLinkToDirect(bookUrl)!){
            openPDF(remoteURL: remoteLink, navVM: navVm)
        }
    }
    
    
    private func continueToQuestions(){
        navVm.replaceTop(route: .examPracticeScreen)
    }
}

#Preview {
    StudyNoteScreen(title: "Types of Books", passage: "Instruction: Try to get the types of books", passageImage: nil, passageBook: "https://drive.google.com/file/d/1nd9YULgoj9WtpJUC7ejcPOg5ccVp6RMr/view?usp=drive_link", passageVideo: "https://www.youtube.com/watch?v=ecBAqCQ1kkY", navVm: MainNavViewModel())
}
