//
//  GlobalBottomSheetView.swift
//  Q and A
//
//  Created by GIGL-PC on 08/04/2026.
//

import SwiftUI

struct GlobalBottomSheetView: View {
        let data: BottomSheetData
        let dismiss: () -> Void
        
        var body: some View {
            VStack(spacing: 16) {
                
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.top, 8)
                
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(iconColor)
                
                Text(data.message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                if let title = data.actionTitle {
                    Button(title) {
                        dismiss()
                        data.action()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                Button("Close") {
                    dismiss()
                }
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .shadow(radius: 10)
        }
        
        private var icon: String {
            switch data.type {
            case .error: return "xmark.circle.fill"
            case .success: return "checkmark.circle.fill"
            }
        }
        
        private var iconColor: Color {
            switch data.type {
            case .error: return .red
            case .success: return .green
            }
        }
        
        private var buttonColor: Color {
            switch data.type {
            case .error: return .red
            case .success: return .green
            }
        }
}

#Preview {
    let bottomSheetData = BottomSheetData(type: .error, message: "An error occured", actionTitle: "Continue", action: {
        
    }
        
    )
    GlobalBottomSheetView(data: bottomSheetData, dismiss: {})
}
