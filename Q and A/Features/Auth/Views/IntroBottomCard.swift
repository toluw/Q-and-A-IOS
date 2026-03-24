//
//  IntroBottomCard.swift
//  Q and A
//
//  Created by GIGL-PC on 27/02/2026.
//

import SwiftUI

struct IntroBottomCard: View {
    
    @ObservedObject var viewModel: IntroViewModel
    let completeIntro: () -> Void
    
    var body: some View {
        
        GeometryReader{ geo in
            
            VStack(spacing: 20) {
                
                      Spacer()
                      
                      Text(viewModel.pages[viewModel.currentIndex].title)
                          .font(.title3)
                          .fontWeight(.semibold)
                          .foregroundColor(.white)
                      
                      Text(viewModel.pages[viewModel.currentIndex].subtitle)
                          .font(.subheadline)
                          .foregroundColor(.white.opacity(0.8))
                          .multilineTextAlignment(.center)
                          .padding(.horizontal)
                      
                      Spacer()
                      
                      IntroNavigationButtons(viewModel: viewModel, completeIntro: completeIntro)
                  }
                  .padding()
                
                  .frame(maxWidth: .infinity, maxHeight: .infinity)
                  .background(
                      Color.black
                    )
                  .clipShape(
                      .rect(
                          topLeadingRadius: 70,
                          topTrailingRadius: 70
                      )
                  )
        }
            
        }
        
       
}

#Preview {
    IntroBottomCard(viewModel: IntroViewModel(), completeIntro: {})
}
