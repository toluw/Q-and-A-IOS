//
//  ExamLoaderScreen.swift
//  Q and A
//
//  Created by GIGL-PC on 30/05/2026.
//

import SwiftUI

struct ExamLoaderScreen: View {
    
    @ObservedObject var navVm: MainNavViewModel
    @State private var countdown = 4
    @State private var progress: CGFloat = 0
    private let totalSeconds = 4
    
    
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 32){
                
                Text("Starting in...").font(AppFont.semi_bold(18))
                
                ZStack{
                    
                    // Background Circle
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 14)
                            .frame(width: 130, height: 130)
                    
                    
                    // Progress Circle
                        Circle()
                            .trim(from: 0, to: progress)
                            .stroke(
                                Color("IndGreen"),
                                style: StrokeStyle(
                                    lineWidth: 14,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 130, height: 130)
                            .animation(.linear(duration: 1), value: progress)
                    
                    
                    // Countdown Number
                    Text("\(countdown)")
                        .font(AppFont.bold(40))
                        .foregroundColor(Color("IndGreen"))

                    
                    
                }
            }
            
            
        }.onAppear {
            startCountdown()
        }
    }
    
    private func startCountdown() {
        
        progress = 0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            let currentStep = totalSeconds - countdown + 1
            
            withAnimation(.linear(duration: 1)) {
                progress = CGFloat(currentStep) / CGFloat(totalSeconds)
            }
            
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    navVm.replaceTop(route: .examSceen)
                }
            }
        }
    }
}

#Preview {
    ExamLoaderScreen(navVm: MainNavViewModel())
}
