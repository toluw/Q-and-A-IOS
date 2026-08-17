//
//  TermsView.swift
//  Q and A
//
//  Created by GIGL-PC on 17/08/2026.
//

import SwiftUI

struct TermsView: View {
    
  let onUrlClicked: (String) -> Void
    
    
    var body: some View {
        VStack{
            Text("By registering and account, you have agreed to the")
                .font(AppFont.regular(12))
            
            HStack{
                Button(action:{
                    onUrlClicked(termsUrl)
                }){
                  Text("Terms of Use")
                        .font(AppFont.medium(12))
                }
                
                Text("and").font(AppFont.regular(12)).padding(.horizontal,1)
                
                
                Button(action:{
                    onUrlClicked(privacyUrl)
                }){
                  Text("Privacy Policy")
                        .font(AppFont.medium(12))
                }
                
                
            }
        }
    }
}

#Preview {
    TermsView(onUrlClicked: {dt in})
}
