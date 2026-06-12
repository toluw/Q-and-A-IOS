//
//  PassageScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 12/06/2026.
//

import SwiftUI

struct PassageScreen: View {
    
    let passage: String
    let passageImage: String?
    let passageBook: String?
    let passageVideo: String?
    let pdfFile: String
    @ObservedObject var navVm: MainNavViewModel
    
    
    
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                
                if(!passage.isEmpty){
                    Text(passage)
                        .font(AppFont.regular(14))
                        .padding(.bottom, 4)
                }
                
                if(passageImage?.isEmpty == false){
                    FullWidthImageView(url: passageImage, placeholderHeight: 60)
                }
                
            }.padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 16)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PassageScreen(passage: "Welcome on board. We are glad to mee you", passageImage: nil, passageBook: nil, passageVideo: nil, pdfFile: "", navVm: MainNavViewModel())
}
