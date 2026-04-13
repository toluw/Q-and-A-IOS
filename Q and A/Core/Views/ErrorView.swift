//
//  ErrorView.swift
//  Q and A
//
//  Created by GIGL-PC on 13/04/2026.
//

import SwiftUI

struct ErrorView: View {
    
    let message: String
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 16){
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.red)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            
            Button(action: {
                onRetry()
            }) {
              Text("Retry")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
            }
            
            
            
            
        }
    }
}

#Preview {
    ErrorView(message: "An error occured.", onRetry: {})
}
