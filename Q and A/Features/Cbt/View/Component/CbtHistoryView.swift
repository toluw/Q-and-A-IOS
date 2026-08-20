//
//  CbtHistoryView.swift
//  Q and A
//
//  Created by GIGL-PC on 19/08/2026.
//

import SwiftUI

struct CbtHistoryView: View {
    
    let cbtHistory: CbtHistory
    let onViewResult: () -> Void
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                LoadImageView(url: cbtHistory.image, width: 70, height: 60)
                
                
                VStack(alignment: .leading){
                    Text(cbtHistory.item).font(AppFont.semi_bold(18))
                    
                    Text("taken: \(getPatternFromDate(date: cbtHistory.createdAt))")
                        .font(AppFont.regular(14))
                        .foregroundColor(Color("DescColor"))
                    
                }.padding(.top, 5)
                    .padding(.horizontal, 18)
                
                
                Spacer()
                
                
               
                
                
                
            }.padding(.leading, 16)
             .padding(.top, 16)
            
            
            HStack(){
                
                VStack(alignment: .leading){
                    Text("\(cbtHistory.numQuestions) questions")
                        .font(AppFont.regular(14))
                        .foregroundColor(Color("DescColor"))
                    
                    let time = Int(cbtHistory.examTime) ?? 0
                    
                    Text(time.toHourString()).font(AppFont.regular(14))
                        .foregroundColor(Color("DescColor"))
                }
                
                Spacer()
                
                
                OrangeButton(buttonText: "View Result", action: onViewResult)
                    .frame(width: 120)
                
                
                
            }.padding(.horizontal,16)
                .padding(.top, 8)
                .padding(.bottom, 16)
            
        }.frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(14)
         
    }
}

#Preview {
    CbtHistoryView(cbtHistory: .preview, onViewResult: {})
}
