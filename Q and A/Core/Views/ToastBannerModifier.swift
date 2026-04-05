//
//  ToastBannerModifier.swift
//  Q and A
//
//  Created by GIGL-PC on 05/04/2026.
//

import SwiftUI

struct ToastBannerModifier: ViewModifier {
    
    @Binding var toast: ToastData?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let toast = toast {
                VStack {
                    ToastBannerView(data: toast)
                        .padding(.top, 10)
                        .transition(
                            .move(edge: .top)
                            .combined(with: .opacity)
                        )
                        .onAppear {
                            triggerHaptic(for: toast.type)
                            autoDismiss()
                        }
                    
                    Spacer()
                }
                .animation(.easeInOut(duration: 0.25), value: toast)
            }
        }
    }
    
    private func autoDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                toast = nil
            }
        }
    }
    
    private func triggerHaptic(for type: ToastType) {
        let generator = UINotificationFeedbackGenerator()
        
        switch type {
        case .error:
            generator.notificationOccurred(.error)
        case .success:
            generator.notificationOccurred(.success)
        }
    }
}




