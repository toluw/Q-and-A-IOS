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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PassageScreen(passage: "Welcome on board. We are glad to mee you", passageImage: nil, passageBook: nil, passageVideo: nil, pdfFile: "", navVm: MainNavViewModel())
}
