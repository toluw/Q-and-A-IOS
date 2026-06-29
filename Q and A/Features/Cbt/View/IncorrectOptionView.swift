//
//  IncorrectOptionView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/06/2026.
//

import SwiftUI

struct IncorrectOptionView: View {
    
    let onItemClicked: () -> Void
    
    var body: some View {
        
        Button(action: onItemClicked){
            
            VStack{
                HStack{
                    
                    Image("wrong")
                    
                    VStack(alignment: .leading){
                        
                        Text("Incorrect")
                            .font(AppFont.regular(16))
                            .foregroundColor(Color("red_text"))
                        
                        Spacer().frame(height: 3)
                        
                        Text("Oops, that was an incorrect option")
                            .font(AppFont.regular(16))
                        
                           
                        
                    }.padding(.leading, 8)
                    
                    Spacer()
                    
                    }.padding(.horizontal, 16)
                    .padding(.top,11)
                
                HStack{
                    
                    Spacer()
                   
                    Text("Review Explanation")
                        .font(AppFont.regular(14))
                        .italic()
                        .foregroundColor(Color("GreyText"))
                    
                    
                    Image("icon_arrow")
                        .padding(.leading, 15)
                        .padding(.trailing, 12)
                    
                    
                    
                }.padding(.top, 36)
                    .padding(.bottom, 11)
                
            }.frame(maxWidth: .infinity)
                .background(Color("inc"))
                .cornerRadius(7)
                .contentShape(Rectangle())
            
        }.buttonStyle(.plain)
    }
    
   
    
}


#Preview {
    IncorrectOptionView(onItemClicked: {})
}
