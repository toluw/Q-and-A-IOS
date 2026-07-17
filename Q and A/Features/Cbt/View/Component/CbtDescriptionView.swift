//
//  CbtDescriptionView.swift
//  Q and A
//
//  Created by GIGL-PC on 28/05/2026.
//

import SwiftUI

struct CbtDescriptionView: View {
    
    let duration: String
    let numQuestions: String
    let description: String
    let instruction: String
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
               Spacer()
                
                Text("Read Carefully")
                    .font(AppFont.medium(18))
                    .foregroundColor(Color("GreyText"))
                
                Spacer()
                
            }.padding(.top, 22)
            
            Text("Description")
                .font(AppFont.semi_bold(18))
                .padding(.top, 22)
                .padding(.leading, 16)
            
            HStack{
               Text(numQuestions)
                    .font(AppFont.regular(16))
                    .foregroundColor(Color("GreyText"))
                
                Circle()
                    .frame(width: 3, height: 3)
                    .foregroundColor(Color("GreyText"))
                
                Text(duration)
                     .font(AppFont.regular(16))
                     .foregroundColor(Color("GreyText"))
                
                
                
            }.padding(.leading, 16)
                .padding(.top, 8)
            
            
            Text(description)
                .font(AppFont.regular(14))
                .foregroundColor(Color("DescColor"))
                .padding(.top, 8)
                .padding(.leading, 16)
                .padding(.trailing, 16)
            
            
            Text("Instruction")
                .font(AppFont.semi_bold(18))
                .padding(.top, 32)
                .padding(.leading, 16)
            
            Text(instruction)
                .font(AppFont.regular(14))
                .foregroundColor(Color("DescColor"))
                .padding(.top, 8)
                .padding(.leading, 16)
                .padding(.trailing, 16)
            
            
        }
    }
}

#Preview {
    CbtDescriptionView(duration: "40 min", numQuestions: "100 questions", description: "Answer each question as soon as possible", instruction: "Do not use Biro")
}
