//
//  ResultScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 07/06/2026.
//

import SwiftUI

struct ResultScreen: View {
  
    @ObservedObject var navVm: MainNavViewModel
    @ObservedObject var cbtViewModel: CbtViewModel
    let examResultData: ExamResultData
    var isMultiple: Bool = false
    
    
    var body: some View {
        VStack{
            
            if(!isMultiple){
               
                LoadImageView(url: examResultData.examResult.image, width: 64, height: 64).padding(.top, 10)
                
                Text("EXAM REPORT")
                    .font(AppFont.semi_bold(14))
                    .foregroundColor(Color("DescColor"))
                    .padding(.top, 40)
                
                Text(examResultData.examResult.category)
                    .font(AppFont.bold(18))
                    .padding(.top, 14)
                
                Text(examResultData.examResult.item)
                    .font(AppFont.medium(18))
                
                
                
            }
            
            HStack{
                Text("Score: \(String(examResultData.examResult.score).formatScore())%")
                    .foregroundColor(Color("score_green"))
                    .font(AppFont.semi_bold(14))
                
                Circle()
                    .frame(width: 4, height: 4)
                    .foregroundColor(Color("GreyText"))
                    .padding(.leading, 8)
                
                Text("\(examResultData.examResult.numQuestions) questions")
                    .foregroundColor(Color("DescColor"))
                    .font(AppFont.regular(14))
                    .padding(.leading, 8)
                
                Circle()
                    .frame(width: 4, height: 4)
                    .foregroundColor(Color("GreyText"))
                    .padding(.leading, 8)
                
                Text(examResultData.examResult.timeDuration == 0 ? examResultData.examResult.examTime.toHourString() : "Time spent: \(convertSecondsToFormattedTime(seconds: examResultData.examResult.timeDuration))")
                    .foregroundColor(Color("DescColor"))
                    .font(AppFont.regular(14))
                    .padding(.leading, 8)
                
            
                
                
                
            }.padding(.top, 35)
            
            
            Text(examResultData.examResult.getReportTxt(user: UserSettings.name ?? ""))
                .font(AppFont.regular(16))
                .padding(.top,30)
                .multilineTextAlignment(.center)
                  .frame(maxWidth: .infinity)
                
            
            HStack{
                VStack{
                  Text("SCORE")
                        .font(AppFont.semi_bold(14))
                    
                    Text("\(String(examResultData.examResult.score).formatScore())%")
                        .font(AppFont.bold(22))
                    
                }
                
                Spacer()
            }.padding(.top, 40)
            
            
            Spacer()
            
            
            VStack{
                
                if(!examResultData.examResult.disableReview){
                    
                    Button(action: reviewResult
                        ) {
                        Text("Review Result")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                            .background(Color("NavBlue"))
                            .cornerRadius(10)
                    }.padding(.bottom, 19)
                    
                }
              
                
                Text("Assessment verified on \(examResultData.examResult.createAt)")
                    .font(AppFont.regular(14))
                    .foregroundColor(Color("DescColor"))
                
            }.frame(maxWidth: .infinity)
                .padding(.bottom, 40)
            
            
           
            
            
            
            
        }.frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
    }
    
    private func reviewResult(){
        
        if(examResultData.examResult.endTime.isEmpty){
            moveToExamReview()
        }else{
           //A quiz exam
        }
        
    }
    
    func moveToExamReview(){
        cbtViewModel.reviewExamList = examResultData.liveExamList
        cbtViewModel.reviewIndex = 0
        cbtViewModel.updateReviewExam(liveExamUpdateMode: .normal)
        navVm.navigate(route: .reviewExamScreen(examId: examResultData.examResult.examId))
    }
}

#Preview {
    ResultScreen(navVm: MainNavViewModel(), cbtViewModel: CbtViewModel(),  examResultData: ExamResultData.preview)
}
