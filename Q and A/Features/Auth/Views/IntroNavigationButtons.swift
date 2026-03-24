//
//  IntroNavigationButtons.swift
//  Q and A
//
//  Created by GIGL-PC on 27/02/2026.
//

import SwiftUI

struct IntroNavigationButtons: View {
    
    @ObservedObject var viewModel: IntroViewModel
    let completeIntro: () -> Void
    
    var body: some View {
        HStack {
            
            // Back
            if viewModel.currentIndex > 0 {
                Button {
                    withAnimation(){
                        viewModel.previous()
                    }
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            } else {
                Button("Skip") {
                    completeIntro()
                }
                .foregroundColor(.white)
            }
            
            Spacer()
            
            Button {
                if viewModel.isLastPage {
                    completeIntro()
                } else {
                    withAnimation(){
                        viewModel.next()
                    }
                    
                }
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    
    
    
    
    
}

#Preview {
    IntroNavigationButtons(viewModel: IntroViewModel(), completeIntro: {})
}
