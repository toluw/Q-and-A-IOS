//
//  IntroStackView.swift
//  Q and A
//
//  Created by GIGL-PC on 29/01/2026.
//

import SwiftUI

struct IntroStackView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject  var viewModel = IntroViewModel()
    
    var body: some View {
        
        
        GeometryReader{geo in
            
            ZStack {
                
                // Background color from Assets
                Color("Background")
                    .ignoresSafeArea()
                
                VStack {
                    
                    // Pager
                    TabView(selection: $viewModel.currentIndex) {
                        ForEach(Array(viewModel.pages.enumerated()), id: \.element.id) { index, page in
                            
                            VStack {
                                Image(page.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal)
                                
                                Spacer()
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height: geo.size.height * 0.53)
                    
                    IntroBottomCard(viewModel: viewModel)
                        .frame(height: geo.size.height * 0.47)
                }
            }
            
        }
        
         
       }
}

#Preview {
    IntroStackView()
}
