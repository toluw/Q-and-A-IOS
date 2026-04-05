//
//  ToastBannerView.swift
//  Q and A
//
//  Created by GIGL-PC on 05/04/2026.
//

import SwiftUI

struct ToastBannerView: View {
    
    let data: ToastData
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: icon)
                .foregroundColor(iconColor)
            
            Text(data.message)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor, lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
        .padding(.horizontal)
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
    
    private var borderColor: Color {
        switch data.type {
        case .error: return .red.opacity(0.3)
        case .success: return .green.opacity(0.3)
        }
    }
}

#Preview {
    ToastBannerView(data: ToastData(message: "An error occured", type: .error))
}
